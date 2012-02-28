#include "UWSimUtils.h"
#include <osg/Material>
#include <osg/ShapeDrawable>
#include <osg/Shape>
#include <osg/Geode>
#include <osg/Switch>
#include <osg/MatrixTransform>

// Default constructor - initialize searchForName to "" and 
// set the traversal mode to TRAVERSE_ALL_CHILDREN
findNodeVisitor::findNodeVisitor() : osg::NodeVisitor(TRAVERSE_ALL_CHILDREN), 
                                        searchForName() 
{ 
} 

// Constructor that accepts string argument
// Initializes searchForName to user string
// set the traversal mode to TRAVERSE_ALL_CHILDREN
findNodeVisitor::findNodeVisitor(const std::string &searchName) : 
                                   osg::NodeVisitor(TRAVERSE_ALL_CHILDREN), 
                                   searchForName(searchName) 
{ 
} 

 //The 'apply' method for 'node' type instances.
 //Compare the 'searchForName' data member against the node's name.
 //If the strings match, add this node to our list
void findNodeVisitor::apply(osg::Node &searchNode) 
{ 
   //std::cerr << "Compare " << searchForName << " to "  << searchNode.getName() << std::endl;
   if (searchNode.getName() == searchForName)
   {
      foundNodeList.push_back(&searchNode);
   }
   traverse(searchNode); 
} 

// Set the searchForName to user-defined string
void findNodeVisitor::setNameToFind(const std::string &searchName) 
{ 
   searchForName = searchName; 
   foundNodeList.clear(); 
} 


osg::Node* findNodeVisitor::getFirst()
{
   if (foundNodeList.size()==0) return NULL;
   else return foundNodeList[0];
}


findRoutedNode::findRoutedNode() : nodeVisitor()
{ 
} 

findRoutedNode::findRoutedNode(const std::string &searchName) :   nodeVisitor(), searchRoute(searchName)
{ 
} 

void findRoutedNode::setNameToFind(const std::string &searchName) 
{ 
   searchRoute = searchName; 
   rootList.clear();
} 

void findRoutedNode::find(osg::ref_ptr<osg::Node> searchNode){
  unsigned int pos=0;
  rootList.clear();
  rootList.push_back(searchNode);
  nodeListType auxList,auxList2;

  while((pos=searchRoute.find("/"))<searchRoute.size()){
    for(unsigned int i=0;i<rootList.size();i++){
      nodeVisitor.setNameToFind(searchRoute.substr(0,pos));
      rootList[i]->accept(nodeVisitor);
      auxList2=nodeVisitor.getNodeList();
      auxList.insert(auxList.end(),auxList2.begin(),auxList2.end());
    }
    searchRoute.erase(0,pos+1);
    rootList=auxList;
    auxList.clear();
  }
  for(unsigned int i=0;i<rootList.size();i++){
      nodeVisitor.setNameToFind(searchRoute);
      rootList[i]->accept(nodeVisitor);
      auxList2=nodeVisitor.getNodeList();
      auxList.insert(auxList.end(),auxList2.begin(),auxList2.end());
    }
    rootList=auxList;
}

osg::Node* findRoutedNode::getFirst()
{
   if (rootList.size()==0) return NULL;
   else return rootList[0];
}

osg::Node* UWSimGeometry::createSwitchableFrame(double radius, double length) {
   osg::Switch *axis=new osg::Switch();
   axis->setNewChildDefaultValue(false);
   axis->setName("switch_frames");
   axis->addChild(UWSimGeometry::createFrame());
   return axis;
}

osg::Node* UWSimGeometry::createFrame(double radius, double length) {
  osg::MatrixTransform *linkBaseTransform= new osg::MatrixTransform(osg::Matrix());

  //create XBase to rotate
  osg::Matrix XBase;
  XBase.preMultRotate(osg::Quat(M_PI_2,osg::Vec3d(1,0,0)));
  XBase.preMultTranslate(osg::Vec3d(0,0,length/2));
  osg::MatrixTransform *XBaseTransform= new osg::MatrixTransform(XBase);
  linkBaseTransform->addChild(XBaseTransform);

  //create X cylinder, set color, and add to XBase
  osg::Node *Xcylinder = UWSimGeometry::createOSGCylinder( radius, length );
  osg::StateSet * Xstateset = new osg::StateSet();
  osg::Material * Xmaterial = new osg::Material();
  Xmaterial->setDiffuse(osg::Material::FRONT_AND_BACK, osg::Vec4(1,0,0,0));
  Xstateset->setAttribute(Xmaterial);
  Xcylinder->setStateSet(Xstateset);
  XBaseTransform->addChild(Xcylinder);

  //create YBase to rotate
  osg::Matrix YBase;
  YBase.makeIdentity();
  YBase.preMultRotate(osg::Quat(M_PI_2,osg::Vec3d(0,1,0)));
  YBase.preMultTranslate(osg::Vec3d(0,0,length/2));
  osg::MatrixTransform *YBaseTransform= new osg::MatrixTransform(YBase);
  linkBaseTransform->addChild(YBaseTransform);

  //create Y cylinder, set color, and add to YBase
  osg::Node * Ycylinder = UWSimGeometry::createOSGCylinder( radius, length );
  osg::StateSet * Ystateset = new osg::StateSet();
  osg::Material * Ymaterial = new osg::Material();
  Ymaterial->setDiffuse(osg::Material::FRONT_AND_BACK, osg::Vec4(0,1,0,0));
  Ystateset->setAttribute(Ymaterial);
  Ycylinder->setStateSet(Ystateset);
  YBaseTransform->addChild(Ycylinder);

  //create ZBase to rotate
  osg::Matrix ZBase;
  ZBase.makeIdentity();
  ZBase.preMultRotate(osg::Quat(M_PI_2,osg::Vec3d(0,0,1)));
  ZBase.preMultTranslate(osg::Vec3d(0,0,length/2));
  osg::MatrixTransform *ZBaseTransform= new osg::MatrixTransform(ZBase);
  linkBaseTransform->addChild(ZBaseTransform);

  //create Z cylinder, set color, and add to ZBase
  osg::Node * Zcylinder = UWSimGeometry::createOSGCylinder( radius, length );
  osg::StateSet * Zstateset = new osg::StateSet();
  osg::Material * Zmaterial = new osg::Material();
  Zmaterial->setDiffuse(osg::Material::FRONT_AND_BACK, osg::Vec4(0,0,1,0));
  Zstateset->setAttribute(Zmaterial);
  Zcylinder->setStateSet(Zstateset);
  ZBaseTransform->addChild(Zcylinder);

  return linkBaseTransform;
}

osg::Node * UWSimGeometry::createOSGBox( osg::Vec3 size )
{
    osg::ref_ptr<osg::Box> box = new osg::Box();

    box->setHalfLengths( size/2 );

    osg::ref_ptr<osg::ShapeDrawable> shape = new osg::ShapeDrawable( box);
    osg::ref_ptr<osg::Geode> geode = new osg::Geode();
    geode->addDrawable( shape );

    osg::Node* node = new osg::Group();
    node->asGroup()->addChild( geode );

    return node;
}

osg::Node* UWSimGeometry::createOSGCylinder( double radius, double height )
{
    osg::ref_ptr<osg::Cylinder> cylinder = new osg::Cylinder();

    cylinder->setRadius( radius );
    cylinder->setHeight( height );

    osg::ref_ptr<osg::ShapeDrawable> shape = new osg::ShapeDrawable( cylinder );
    osg::ref_ptr<osg::Geode> geode = new osg::Geode();
    geode->addDrawable( shape );

    osg::Node *node = new osg::Group();
    node->asGroup()->addChild( geode );

    return node;
}

osg::Node * UWSimGeometry::createOSGSphere( double radius )
{
    osg::ref_ptr<osg::Sphere> sphere = new osg::Sphere();

    sphere->setRadius( radius );

    osg::ref_ptr<osg::ShapeDrawable> shape = new osg::ShapeDrawable( sphere );
    osg::ref_ptr<osg::Geode> geode = new osg::Geode();
    geode->addDrawable( shape );

    osg::ref_ptr<osg::Node> node = new osg::Group();
    node->asGroup()->addChild( geode );

    return node;
}
