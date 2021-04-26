underwater_simulation
=====================

UWSim, the Underwater Simulator


** Note** This version is ligher than the upstream, without plugins and dynamics. 

Installation instructions
------------------------

- Download this repository inside a ROS workspace
- Install required dependencies: `sudo apt install -y libopenscenegraph-dev libfftw3-dev libxml++2.6-dev ros-$ROS1_DISTRO-control-toolbox`

- Provided dependencies lie in `3rd_parties`
- Compile them with: `cmake` / `sudo make install`
- Then compile the workspace with catkin: `catkin build uwsim`



Upstream information
--------------------

Installation instructions here:

http://www.irs.uji.es/uwsim/wiki/index.php?title=Installing_UWSim

Project website:

http://www.irs.uji.es/uwsim

Please join our mailing list:

https://groups.google.com/a/uji.es/forum/#!forum/uji-ros-pkg-support

