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
CC=afl-gcc CXX=afl-g++ $SRC/configure --disable-shared
AFL_USE_ASAN=1 make