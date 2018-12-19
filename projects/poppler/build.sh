#!/bin/bash
echo "update source"
cd $SRC
git pull origin
rm -rf build && mkdir build && cd build
cmake \
    -DCMAKE_C_COMPILER=afl-gcc \
    -DCMAKE_CXX_COMPILER=afl-g++ \
    -DCMAKE_BUILD_TYPE=debugfull \
    -DBUILD_GTK_TESTS=OFF \
    -DBUILD_QT5_TESTS=OFF \
    -DENABLE_QT5=OFF \
    -DENABLE_GTK_DOC=OFF \
    -DENABLE_GLIB=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DTESTDATADIR=/work/test \
    ..
AFL_HARDEN=1 make
cd ..
rm -rf build_normal && mkdir build_normal && cd build_normal
cmake \
    -DCMAKE_BUILD_TYPE=debugfull \
    -DBUILD_GTK_TESTS=OFF \
    -DBUILD_QT5_TESTS=OFF \
    -DENABLE_QT5=OFF \
    -DENABLE_GTK_DOC=OFF \
    -DENABLE_GLIB=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DTESTDATADIR=/work/test \
    ..
make
