ExternalProject_Add(Ogredeps
  HG_REPOSITORY "https://bitbucket.org/cabalistic/ogredeps" 
  PATCH_COMMAND "git apply < ${CMAKE_CURRENT_SOURCE_DIR}/CMake/SDL-Cmake.patch"
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/Tools/Ogredeps
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/Run/
)
