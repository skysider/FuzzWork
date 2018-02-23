FROM skysider/fuzzbase:latest

LABEL maintainer="junchaoluan@gmail.com"

RUN apt-get -y update && \
    apt-get install -y \
    libzip-dev && \
    rm -rf /var/lib/apt/list/*

COPY build.sh /work/

RUN git clone --depth=1 https://github.com/gdraheim/zziplib && \
    chmod a+x ./build.sh

ENV SRC=/work/zziplib

COPY zziplib-manpages.tar $SRC/docs/

CMD [ "/bin/bash" ]