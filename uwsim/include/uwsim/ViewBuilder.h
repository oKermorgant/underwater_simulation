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

#ifndef VIEWBUILDER_H
#define VIEWBUILDER_H

#include <osgWidget/Util>
#include <osgOcean/OceanScene>

#include "osgOceanScene.h"
#include "HUDCamera.h"
#include "ROSInterface.h"
#include "SimulatedIAUV.h"
#include "ConfigXMLParser.h"
#include "SceneBuilder.h"

class ViewBuilder
{
public:
  osg::ref_ptr<osgViewer::Viewer> viewer;
  std::shared_ptr<osg::ArgumentParser> arguments;
  int fullScreenNum;

public:
  osg::ref_ptr<osgWidget::WindowManager> wm;
  ViewBuilder(ConfigFile &config, SceneBuilder *scene_builder);
  ViewBuilder(ConfigFile &config, SceneBuilder *scene_builder, int *argc, char **argv);
  ViewBuilder(ConfigFile &config, SceneBuilder *scene_builder, std::shared_ptr<osg::ArgumentParser> args);

  void updateSeaOffset(SceneBuilder &scene_builder)
  {
    static double z_prev(0);
    auto z(viewer.get()->getCameraManipulator()->getMatrix().getTrans().z());
    if(z*z_prev <= 0)
      scene_builder.getScene()->getOceanScene()->setOceanSurfaceHeight(z > 0 ? 0.01 : -0.01);
    z_prev = z;
  }

  osgViewer::View* getView()
  {
    return viewer.get();
  }
  osgViewer::Viewer* getViewer()
  {
    return viewer.get();
  }
  void init();

  ~ViewBuilder()
  {
  }

protected:
  bool init(ConfigFile &config, SceneBuilder *scene_builder);
};

#endif
