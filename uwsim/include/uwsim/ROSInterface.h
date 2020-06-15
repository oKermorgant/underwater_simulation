/* 
 * Copyright (c) 2013 University of Jaume-I.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v3.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/gpl.html
 * 
 * Contributors:
 *     Mario Prats
 *     Javier Perez
 */

#ifndef ROSINTERFACE_H_
#define ROSINTERFACE_H_

//UWSIM
#include "SimulatorConfig.h"

#include "URDFRobot.h"
#include "SimulatedIAUV.h"
#include "VirtualCamera.h"
#include "GPSSensor.h"
#include "HUDCamera.h"
#include "UWSimUtils.h"
#include "SceneBuilder.h"

//OSG
#include <OpenThreads/Thread>
#include <osg/PrimitiveSet>
#include <osg/Geode>
#include <osg/Vec3>
#include <osg/Vec4>
#include <osg/Drawable>
#include <osg/Geometry>

//STL
#include <vector>

#include <boost/shared_ptr.hpp>

//ROS
#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include <sensor_msgs/JointState.h>
#include <nav_msgs/Odometry.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/distortion_models.h>
#include <image_transport/image_transport.h>
#include <geometry_msgs/TwistStamped.h>
#include <geometry_msgs/Pose.h>
#include <robot_state_publisher/robot_state_publisher.h>

//Max time (in seconds) between two consecutive control references
#define MAX_ELAPSED	1

class ROSInterface : public OpenThreads::Thread
{
protected:
  std::string topic;
  ros::NodeHandle nh_;
  static ros::Time current_time_;

public:
  ROSInterface(std::string topic)
  {
    this->topic = topic;
  }

  virtual ~ROSInterface()
  {
  }

  /**
   * Sets the static ros time in the ROSInterface,
   * to be called once per simulation step
   */
  static void setROSTime(const ros::Time& time)
  {
    current_time_ = time;
  }

  /**
   * Retrieve the current ROS time.
   * Use this instead of calling ros::Time::now()
   * when setting the timestamp of your messages.
   */
  static ros::Time getROSTime()
  {
    return current_time_;
  }
};

class ROSSubscriberInterface : public ROSInterface
{
protected:
  ros::Subscriber sub_;
public:
  ROSSubscriberInterface(std::string topic);

  virtual void createSubscriber(ros::NodeHandle &nh)=0;

  /* Thread code */
  void run();

  ~ROSSubscriberInterface();
};

class ROSOdomToPAT : public ROSSubscriberInterface
{
  osg::ref_ptr<osg::MatrixTransform> transform;
  ros::WallTime last;
  int started;

public:
  ROSOdomToPAT(osg::Group *rootNode, std::string topic, std::string vehicleName);

  virtual void createSubscriber(ros::NodeHandle &nh);

  virtual void processData(const nav_msgs::Odometry::ConstPtr& odom);
  ~ROSOdomToPAT();
};

class ROSTwistToPAT : public ROSSubscriberInterface
{
  osg::ref_ptr<osg::MatrixTransform> transform;
  ros::WallTime last;
  int started;
public:
  ROSTwistToPAT(osg::Group *rootNode, std::string topic, std::string vehicleName);

  virtual void createSubscriber(ros::NodeHandle &nh);

  virtual void processData(const geometry_msgs::TwistStamped::ConstPtr& odom);
  ~ROSTwistToPAT();
};

class ROSPoseToPAT : public ROSSubscriberInterface
{
  osg::ref_ptr<osg::MatrixTransform> transform;
public:
  ROSPoseToPAT(osg::Group *rootNode, std::string topic, std::string vehicleName);

  virtual void createSubscriber(ros::NodeHandle &nh);

  virtual void processData(const geometry_msgs::Pose::ConstPtr& odom);
  ~ROSPoseToPAT();
};

class ROSJointStateToArm : public ROSSubscriberInterface
{
  std::shared_ptr<SimulatedIAUV> arm;
public:
  ROSJointStateToArm(std::string topic, std::shared_ptr<SimulatedIAUV> arm);
  virtual void createSubscriber(ros::NodeHandle &nh);

  virtual void processData(const sensor_msgs::JointState::ConstPtr& js);
  ~ROSJointStateToArm();
};

class ROSImageToHUDCamera : public ROSSubscriberInterface
{
  std::shared_ptr<HUDCamera> cam;
  std::shared_ptr<image_transport::ImageTransport> it;
  image_transport::Subscriber image_sub;
  std::string image_topic;
public:
  ROSImageToHUDCamera(std::string topic, std::string info_topic, std::shared_ptr<HUDCamera> camera);

  virtual void createSubscriber(ros::NodeHandle &nh);

  virtual void processData(const sensor_msgs::ImageConstPtr& msg);
  ~ROSImageToHUDCamera();
};

class ROSPublisherInterface : public ROSInterface
{
protected:
  int publish_rate;
  ros::Publisher pub_;
public:
  ROSPublisherInterface(std::string topic, int publish_rate);

  virtual void createPublisher(ros::NodeHandle &nh)=0;
  virtual void publish()=0;

  /* Thread code */
  void run();

  ~ROSPublisherInterface();
};

class PATToROSOdom : public ROSPublisherInterface
{
  osg::ref_ptr<osg::MatrixTransform> transform;
public:
  PATToROSOdom(osg::Group *rootNode, std::string vehicleName, std::string topic, int rate);

  void createPublisher(ros::NodeHandle &nh);

  void publish();

  ~PATToROSOdom();
};

class WorldToROSTF : public ROSPublisherInterface
{
  std::vector< osg::ref_ptr<osg::MatrixTransform> > transforms_;
  std::vector< std::shared_ptr<robot_state_publisher::RobotStatePublisher> > robot_pubs_;
  std::shared_ptr<tf::TransformBroadcaster> tfpub_;
  std::string worldRootName_; 
  unsigned int enableObjects_;
  SceneBuilder * scene;
public:
  WorldToROSTF(SceneBuilder * scene, std::string worldRootName, unsigned int enableObjects, int rate);

  void createPublisher(ros::NodeHandle &nh);

  void publish();

  ~WorldToROSTF();
};

class GPSSensorToROS : public ROSPublisherInterface
{
  GPSSensor *sensor_;

public:
  GPSSensorToROS(GPSSensor *sensor, std::string topic, int rate) :
      ROSPublisherInterface(topic, rate), sensor_(sensor)
  {
  }

  void createPublisher(ros::NodeHandle &nh);

  void publish();

  ~GPSSensorToROS()
  {
  }
};

class ArmToROSJointState : public ROSPublisherInterface
{
  std::shared_ptr<URDFRobot> arm;
public:
  ArmToROSJointState(SimulatedIAUV *arm, std::string topic, int rate);

  void createPublisher(ros::NodeHandle &nh);

  void publish();

  ~ArmToROSJointState();
};

class VirtualCameraToROSImage : public ROSPublisherInterface
{

  //Updates camera buffer when publisher is not publishing
  class CameraBufferCallback : public osg::Camera::DrawCallback
  {
    public:
      virtual void operator () (const osg::Camera& camera) const;
      CameraBufferCallback(VirtualCameraToROSImage * publisher,VirtualCamera *camera,int depth);
    private:

      VirtualCameraToROSImage * pub;
      VirtualCamera *cam;
      int depth;
  };

  std::shared_ptr<image_transport::ImageTransport> it;
  image_transport::Publisher img_pub_;
  std::string image_topic;
  VirtualCamera *cam;
  int depth;
  int bw;
public:

  VirtualCameraToROSImage(VirtualCamera *camera, std::string topic, std::string info_topic, int rate, int depth);

  void createPublisher(ros::NodeHandle &nh);

  void publish();

  ~VirtualCameraToROSImage();

  osg::ref_ptr < osg::Image > osgimage;
  OpenThreads::Mutex mutex; //Mutex to avoid image overwriting

};

#endif
