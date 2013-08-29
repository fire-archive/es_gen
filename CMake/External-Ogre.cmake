ExternalProject_Add(Ogre
  DEPENDS Ogredeps
  HG_REPOSITORY "https://bitbucket.org/sinbad/ogre" 
  HG_TAGS "v1-8"
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/Tools/Ogre
)