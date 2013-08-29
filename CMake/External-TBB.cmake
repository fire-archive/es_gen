if(NOT TBB_FOUND)
  message(ERROR "Cannot find Intel Threading Building Blocks. TBB is required for building")
endif()