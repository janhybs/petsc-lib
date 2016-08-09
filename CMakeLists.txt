cmake_minimum_required(VERSION 2.6)

project(PETSC CXX C Fortran)
find_program (MAKE_EXECUTABLE NAMES make gmake)

set(PETSC_VERSION_MAJOR "3")
set(PETSC_VERSION_MINOR "6")
set(PETSC_VERSION_PATCH "1")
set(PETSC_VERSION "${PETSC_VERSION_MAJOR}.${PETSC_VERSION_MINOR}.${PETSC_VERSION_PATCH}")

# default variables
SET(BUILD_TYPE        "debug")
SET(PETSC_INSTALL_DIR "${CMAKE_BINARY_DIR}")
SET(PETSC_INSTALL_URL "http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${PETSC_VERSION}.tar.gz")


# setup external project with target petsc-lib
include(ExternalProject)
ExternalProject_Add(petsc-lib
    DOWNLOAD_DIR ${PETSC_INSTALL_DIR} 
    URL ${PETSC_INSTALL_URL}
    SOURCE_DIR ${PETSC_INSTALL_DIR}/src
    BINARY_DIR ${PETSC_INSTALL_DIR}/src
    
    CONFIGURE_COMMAND   ""
    BUILD_COMMAND       ""
    INSTALL_COMMAND     ""
)

# prepare configure script for petsc and copy if different to isntall dir
configure_file(
    ${CMAKE_SOURCE_DIR}/config/${BUILD_TYPE}.config.sh
    ${PETSC_INSTALL_DIR}/conf_tmp.sh
    @ONLY)
execute_process(COMMAND
    ${CMAKE_COMMAND} -E copy_if_different "${PETSC_INSTALL_DIR}/conf_tmp.sh" "${PETSC_INSTALL_DIR}/conf.sh")

# add install rule, for now we copy everything in src dir
install(
	DIRECTORY ${PETSC_INSTALL_DIR}/src/
	DESTINATION lib/petsc
)
    
# CPack configuration 
SET(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
SET(CPACK_PACKAGE_FILE_NAME "PETSC_${PETSC_VERSION}")
SET(CPACK_GENERATOR "DEB;TGZ;ZIP")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)