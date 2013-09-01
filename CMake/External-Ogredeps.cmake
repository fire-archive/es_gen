ExternalProject_Add(Ogredeps
  HG_REPOSITORY "https://bitbucket.org/cabalistic/ogredeps" 
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/Tools/Ogredeps
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/Tools/Ogredeps/Dependencies
)