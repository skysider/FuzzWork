#!/bin/bash
BUILD_DIR="build"
echo "build xpdf with afl-gcc"
if [ -d "$BUILD_DIR" ]; then
    rm -rf $BUILD_DIR
fi 
mkdir $BUILD_DIR
cd $BUILD_DIR
export AFL_USE_ASAN=1
cmake \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt5Widgets=1 \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt4=1 \
    -DCMAKE_C_COMPILER=afl-gcc \
    -DCMAKE_CXX_COMPILER=afl-g++ \
    -DCMAKE_C_FLAGS="-g -O0 -ggdb" \
    -DCMAKE_CXX_FLAGS="-g -O0 -ggdb" \
    -DBUILD_SHARED_LIBS=OFF \
    --build ${SRC}
make