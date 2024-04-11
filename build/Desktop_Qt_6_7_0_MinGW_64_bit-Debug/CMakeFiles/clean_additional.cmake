# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appAnalog_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appAnalog_autogen.dir\\ParseCache.txt"
  "appAnalog_autogen"
  )
endif()
