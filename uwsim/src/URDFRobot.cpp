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

#include <uwsim/URDFRobot.h>
#include <uwsim/UWSimUtils.h>
#include <osg/ShapeDrawable>
#include <osg/Material>
#include <math.h>


URDFRobot::URDFRobot(osgOcean::OceanScene *oscene, Vehicle vehicle) :
    KinematicChain(vehicle.nlinks, vehicle.njoints)
{
  ScopedTimer buildSceneTimer("Loading URDF robot... \n", osg::notify(osg::ALWAYS));
  const std::string SIMULATOR_DATA_PATH = std::string(getenv("HOME")) + "/.uwsim/data";

  osgDB::Registry::instance()->getDataFilePathList().push_back(
      std::string(SIMULATOR_DATA_PATH) + std::string("/robot"));
  osgDB::Registry::instance()->getDataFilePathList().push_back(
      std::string(UWSIM_ROOT_PATH) + std::string("/data/shaders"));
  osgDB::Registry::instance()->getDataFilePathList().push_back(
      std::string(SIMULATOR_DATA_PATH) + std::string("/textures"));

  URDFFile=vehicle.URDFFile;

  link.resize(vehicle.nlinks);

  //Create links from geometry nodes
  for (int i = 0; i < vehicle.nlinks; i++)
  {
    ScopedTimer buildSceneTimer("  · " + vehicle.links[i].geom->file + ": ", osg::notify(osg::ALWAYS));

    link[i] = UWSimGeometry::loadGeometry(vehicle.links[i].geom);
    if (!link[i])
      exit(0);
    link[i]->setName(vehicle.links[i].name);

    if (!vehicle.links[i].material.empty())
    { //Add material if exists
      osg::ref_ptr < osg::StateSet > stateset = new osg::StateSet();
      osg::ref_ptr < osg::Material > material = new osg::Material();
      material->setDiffuse(
          osg::Material::FRONT_AND_BACK,
          osg::Vec4(vehicle.materials[vehicle.links[i].material].r, vehicle.materials[vehicle.links[i].material].g,
                    vehicle.materials[vehicle.links[i].material].b, vehicle.materials[vehicle.links[i].material].a));
      stateset->setAttribute(material);
      if (vehicle.materials[vehicle.links[i].material].a < 1)
      {
        stateset->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
        stateset->setMode(GL_BLEND, osg::StateAttribute::ON);
      }
      link[i]->setStateSet(stateset);
    }
  }

  bool success = true;
  for (int i = 0; i < vehicle.nlinks; i++)
  {
    if (!link[i].valid())
    {
      osg::notify(osg::WARN) << "Could not find " << vehicle.name << " link" << i << ".osg "
          << vehicle.links[i + 1].geom->file << std::endl;
      baseTransform = NULL;
      success = false;
    }
  }

  //Create tree hierarchy linkBT->link->linkPT and link links
  if (success)
  {
    ScopedTimer buildSceneTimer("  · Linking links...", osg::notify(osg::ALWAYS));
    osgDB::Registry::instance()->getDataFilePathList().push_back(
        std::string(UWSIM_ROOT_PATH) + std::string("/data/shaders"));
    static const char model_vertex[] = "default_scene.vert";
    static const char model_fragment[] = "default_scene.frag";
    std::vector < osg::ref_ptr<osg::MatrixTransform> > linkBaseTransforms(vehicle.nlinks);
    std::vector < osg::ref_ptr<osg::MatrixTransform> > linkPostTransforms(vehicle.nlinks);

    osg::Matrix linkBase;
    osg::Matrix linkPost;
    for (int i = 0; i < vehicle.nlinks; i++)
    {
      link[i]->setNodeMask(
          oscene->getNormalSceneMask() | oscene->getReflectedSceneMask() | oscene->getRefractedSceneMask());
      linkBase.makeIdentity();
      //linkBase.preMultRotate(osg::Quat(vehicle.links[i].rpy[0],osg::Vec3d(1,0,0)));
      //linkBase.preMultRotate(osg::Quat(vehicle.links[i].rpy[1],osg::Vec3d(0,1,0)));
      //linkBase.preMultRotate(osg::Quat(vehicle.links[i].rpy[2],osg::Vec3d(0,0,1)));
      //linkBase.preMultTranslate(osg::Vec3d(-vehicle.links[i].position[0],-vehicle.links[i].position[1],-vehicle.links[i].position[2]));
      linkBase.makeTranslate(
          osg::Vec3d(vehicle.links[i].position[0], vehicle.links[i].position[1], vehicle.links[i].position[2]));
      linkBase.preMultRotate(
          osg::Quat(vehicle.links[i].quat[0], vehicle.links[i].quat[1], vehicle.links[i].quat[2],
                    vehicle.links[i].quat[3]));
      linkBase.preMultScale(osg::Vec3d(vehicle.links[i].geom->scale[0],vehicle.links[i].geom->scale[1],vehicle.links[i].geom->scale[2]));

      linkBaseTransforms[i] = new osg::MatrixTransform;
      linkBaseTransforms[i]->setMatrix(linkBase);
      link[i]->getOrCreateStateSet()->setMode(GL_NORMALIZE, osg::StateAttribute::ON);
      linkBaseTransforms[i]->addChild(link[i]);

      //linkBase.invert(linkPost);
      linkPost.makeIdentity();
      linkPost.preMultScale(osg::Vec3d(1.0/vehicle.links[i].geom->scale[0],1.0/vehicle.links[i].geom->scale[1],1.0/vehicle.links[i].geom->scale[2]));
      linkPost.preMultRotate(
          osg::Quat(vehicle.links[i].quat[0], vehicle.links[i].quat[1], vehicle.links[i].quat[2],
                    vehicle.links[i].quat[3]).inverse());
      linkPost.preMultTranslate(
          -osg::Vec3d(vehicle.links[i].position[0], vehicle.links[i].position[1], vehicle.links[i].position[2]));
      linkPostTransforms[i] = new osg::MatrixTransform;
      linkPostTransforms[i]->setMatrix(linkPost);
      link[i]->asGroup()->addChild(linkPostTransforms[i]);
    }

    joints.resize(vehicle.njoints);
    zerojoints.resize(vehicle.njoints);

    for (int i = 0; i < vehicle.njoints; i++)
    {
      joints[i] = new osg::MatrixTransform;
      zerojoints[i] = new osg::MatrixTransform;
    }

    osg::Matrix m;
    for (int i = 0; i < vehicle.njoints; i++)
    {
      m.makeTranslate(0, 0, 0);
      m.preMultTranslate(
          osg::Vec3d(vehicle.joints[i].position[0], vehicle.joints[i].position[1], vehicle.joints[i].position[2]));
      m.preMultRotate(
          osg::Quat(vehicle.joints[i].quat[0], vehicle.joints[i].quat[1], vehicle.joints[i].quat[2],
                    vehicle.joints[i].quat[3]));

      joints[i]->setMatrix(m);
      zerojoints[i]->setMatrix(m);
    }

    baseTransform = new osg::MatrixTransform();
    baseTransform->addChild(linkBaseTransforms[0]);

    //Create a frame that can be switched on and off
    osg::ref_ptr < osg::Node > btaxis = UWSimGeometry::createSwitchableFrame();
    //Add label to switchable frame
    btaxis->asGroup()->addChild(UWSimGeometry::createLabel(vehicle.name));
    baseTransform->addChild(btaxis);

    for (int i = 0; i < vehicle.njoints; i++)
    {
      linkPostTransforms[vehicle.joints[i].parent]->asGroup()->addChild(joints[i]);
      joints[i]->addChild(linkBaseTransforms[vehicle.joints[i].child]);

      //Create a frame that can be switched on and off
      osg::ref_ptr < osg::Node > axis = UWSimGeometry::createSwitchableFrame();
      //Add label to switchable frame
      axis->asGroup()->addChild(UWSimGeometry::createLabel(vehicle.joints[i].name));

      joints[i]->addChild(axis);
    }
    //Save rotations for joints update, limits, and type of joints
    joint_axis.resize(vehicle.njoints);
    for (int i = 0; i < vehicle.njoints; i++)
    {
      joint_axis[i] = osg::Vec3d(vehicle.joints[i].axis[0], vehicle.joints[i].axis[1], vehicle.joints[i].axis[2]);
      jointType[i] = vehicle.joints[i].type;
      limits[i] = std::pair<double, double>(vehicle.joints[i].lowLimit, vehicle.joints[i].upLimit);
      names[i] = vehicle.joints[i].name;
    }

    //Save mimic info
    for (int i = 0; i < vehicle.njoints; i++)
    {
      if (vehicle.joints[i].mimicp == -1)
      {
        mimic[i].joint = i;
        mimic[i].offset = 0;
        mimic[i].multiplier = 1;
        mimic[i].sliderCrank = 0;
      }
      else
      {
        mimic[i].joint = vehicle.joints[i].mimicp;
        mimic[i].offset = vehicle.joints[i].mimic->offset;
        mimic[i].multiplier = vehicle.joints[i].mimic->multiplier;
        if (vehicle.joints[i].name.find("slidercrank") != string::npos)
          mimic[i].sliderCrank = 1;
        else
          mimic[i].sliderCrank = 0;
      }
    }

    osg::notify(osg::ALWAYS) << "Robot successfully loaded. Total time: ";
  }
}

void URDFRobot::addToKinematicChain(osg::Node * newLink)
{
  link.push_back(newLink);
}

void URDFRobot::moveJoints(std::vector<double> &q)
{
  osg::Matrix m;

  for (int i = 0; i < getNumberOfJoints(); i++)
  {
    if (jointType[i] == 1)
    {
      if (mimic[i].sliderCrank == 0)
        m.makeRotate(q[mimic[i].joint] * mimic[i].multiplier + mimic[i].offset, joint_axis[i]);
      else
        m.makeRotate((q[mimic[i].joint] + asin(mimic[i].offset * sin(q[mimic[i].joint]))) * -1, joint_axis[i]);
    }
    else if (jointType[i] == 2)
    {
      m.makeTranslate(joint_axis[i] * (q[mimic[i].joint] * mimic[i].multiplier + mimic[i].offset));
    }
    else
      m.makeIdentity();
    osg::Matrix nm = zerojoints[i]->getMatrix();
    nm.preMult(m);
    joints[i]->setMatrix(nm);
  }

}

void URDFRobot::updateJoints(std::vector<double> &q)
{

  moveJoints(q);
}

void URDFRobot::updateJoints(std::vector<double> &q, int startJoint, int numJoints)
{
  osg::Matrix m;

  for (int i = startJoint; i < startJoint + numJoints; i++)
  {
    m.makeRotate(q[mimic[i].joint] * mimic[i].multiplier + mimic[i].offset, joint_axis[i]);
    osg::Matrix nm = zerojoints[i]->getMatrix();
    nm.preMult(m);
    joints[i]->setMatrix(nm);
  }
}

URDFRobot::~URDFRobot()
{
}
