#!/bin/bash
echo "update source"
cd $SRC
git pull origin
cd ..

echo "compile "
BUILD_DIR=build
if [ -d "$BUILD_DIR" ]; then
    rm -rf $BUILD_DIR
fi
mkdir $BUILD_DIR
cd $BUILD_DIR
CC=afl-gcc CXX=afl-g++ $SRC/configure --disable-shared LIBS=-ldl LDFLAGS=-ldl --disable-64-bit-bfd CFLAGS="-g -O0" CXXFLAGS="-g -O0"
AFL_USE_ASAN=1 make all-binutils
cd ../
rm -rf build_normal && mkdir build_normal && cd build_normal
$SRC/configure --disable-shared LIBS=-ldl LDFLAGS=-ldf --disable-64-bit-bfd CFLAGS="-g -O0" CXXFLAGS="-g -O0"
make all-binutils
