FROM skysider/fuzzwork:base_afl

LABEL maintainer="junchaoluan@gmail.com"

RUN apt-get -y update && \
    apt-get install -y \
    texinfo \
    texi2html \
    bison \
    flex && \
   rm -rf /var/lib/apt/list/*

COPY build.sh /work/

RUN git clone --depth=1 git://sourceware.org/git/binutils-gdb.git && \
    chmod a+x ./build.sh

ENV SRC=/work/binutils-gdb

CMD [ "/bin/bash" ]