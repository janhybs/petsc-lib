#!/bin/bash
cd @PETSC_INSTALL_DIR@/src

./configure \
        PETSC_ARCH=linux-release \
        --with-cc=@CMAKE_C_COMPILER@ --with-cxx=@CMAKE_CXX_COMPILER@ --with-fc=@CMAKE_Fortran_COMPILER@ \
        --download-fblaslapack --download-mpich --download-metis=yes --download-parmetis=yes \
        --with-debugging=0 --with-shared-libraries=0 \
        --with-make-np --CFLAGS="-O3 -DNDEBUG" --CXXFLAGS="-O3 -DNDEBUG -Wall -Wno-unused-local-typedefs -std=c++11"