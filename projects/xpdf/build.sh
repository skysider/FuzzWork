#!/bin/bash
BUILD_DIR="build"
echo "build xpdf with afl"
if [ -d "$BUILD_DIR" ]; then
    rm -rf build
fi 
mkdir $BUILD_DIR
cd $BUILD_DIR
export AFL_USE_ASAN=1
cmake \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt5Widgets=1 \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt4=1 \
    -DCMAKE_C_COMPILER=afl-clang \
    -DCMAKE_CXX_COMPILER=afl-clang++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_C_COMPILER_DEBUG='-g -ggdb -O0 -fno-omit-frame-pointer' \
    -DCMAKE_CXX_COMPILER_DEBUG='-g -ggdb -O0 -fno-omit-frame-poniter' \
    -DBUILD_SHARED_LIBS=OFF \
    --build ${SRC}
make
