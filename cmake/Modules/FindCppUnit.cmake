# http://www.cmake.org/pipermail/cmake/2006-October/011446.html
# Modified to use pkg-config and use standard var names

# FindCppUnit.cmake
#
# Locate CppUnit library and headers.
# This module defines the following variables:
#   CPPUNIT_FOUND - True if the library and headers were found
#   CPPUNIT_INCLUDE_DIRS - Where to find the headers
#   CPPUNIT_LIBRARIES - The libraries to link against
#   CPPUNIT_VERSION - The version of CppUnit found (if available)

# Use pkg-config to get hints about paths
find_package(PkgConfig QUIET)
pkg_check_modules(PC_CPPUNIT QUIET cppunit)

set(CPPUNIT_DEFINITIONS ${PC_CPPUNIT_CFLAGS_OTHER})

# Find the CppUnit include directory
find_path(CPPUNIT_INCLUDE_DIR NAMES cppunit/TestCase.h
          HINTS ${PC_CPPUNIT_INCLUDE_DIRS}
          PATHS /usr/include /usr/local/include)

# Find the CppUnit library
find_library(CPPUNIT_LIBRARY NAMES cppunit
             HINTS ${PC_CPPUNIT_LIBRARY_DIRS}
             PATHS /usr/lib /usr/local/lib)

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set CPPUNIT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(CppUnit DEFAULT_MSG
                                  CPPUNIT_LIBRARY CPPUNIT_INCLUDE_DIR)

if(CPPUNIT_FOUND)
  set(CPPUNIT_INCLUDE_DIRS ${CPPUNIT_INCLUDE_DIR})
  set(CPPUNIT_LIBRARIES ${CPPUNIT_LIBRARY})
else()
  set(CPPUNIT_INCLUDE_DIRS)
  set(CPPUNIT_LIBRARIES)
endif()

mark_as_advanced(CPPUNIT_INCLUDE_DIRS CPPUNIT_LIBRARIES)
