#!/usr/bin/env bash

cd exim
git reset --hard cf3cd306062a08969c41a1cdd32c6855f1abecf1~1
cd src
mkdir Local
cp src/EDITME Local/Makefile
cp exim_monitor/EDITME Local/eximon.conf
sed -i 's/^EXIM_USER=/EXIM_USER=exim/' Local/Makefile
useradd exim
FULLECHO="" LFLAGS+="-fsanitize=address -lasan -pie" CFLAGS+="-fPIC -O1 -g -fsanitize=address" LDFLAGS+="-lasan -pie -ldl -lm -lcrypt" LIBS+="-lasan -pie" make -e exim
cd ../..
