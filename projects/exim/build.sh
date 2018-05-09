#!/usr/bin/env bash

cd exim
git pull origin
cd src
rm -rf build-Linux-x86_64
mkdir Local
cp src/EDITME Local/Makefile
cp exim_monitor/EDITME Local/eximon.conf
sed -i 's/^EXIM_USER=/EXIM_USER=exim/' Local/Makefile
useradd exim
CC=clang FULLECHO="" LFLAGS+="-fsanitize=address -pie" CFLAGS+="-fPIC -O1 -g -fno-omit-frame-pointer -fsanitize=address" LDFLAGS+="-pie -ldl -lm -lcrypt" LIBS+="-pie" make -e exim
cd ../..
