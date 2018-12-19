FROM skysider/fuzzwork:base_afl

LABEL maintainer="junchaoluan@gmail.com"

RUN apt-get -y update && \
    apt-get install -y \
    libfreetype6-dev \
    libfontconfig1-dev \
    libnss3-dev \
    libcairo2-dev \
    libopenjp2-7-dev \
    liblcms2-dev \
    libtiff-dev \
    shtool \
    gtk-doc-tools \
    extra-cmake-modules && \
    rm -rf /var/lib/apt/list/*

COPY build.sh /work/

ENV SRC=/work/poppler

RUN git clone --depth=1 https://gitlab.freedesktop.org/poppler/poppler.git && \
    git clone --depth=1 git://git.freedesktop.org/git/poppler/test && \
    chmod +x ./build.sh && ./build.sh


CMD ['/bin/bash']
