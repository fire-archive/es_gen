ExternalProject_Add(Ogre
  DEPENDS Ogredeps
  HG_REPOSITORY "https://bitbucket.org/sinbad/ogre"
  HG_TAG "v1-8"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/Ogre"
  CMAKE_ARGS -DOGRE_DEPENDENCIES_DIR=${CMAKE_BINARY_DIR}/Tools/Ogredeps/Dependencies
)