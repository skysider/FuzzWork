FROM skysider/fuzzwork:base_afl

LABEL maintainer="junchaoluan@gmail.com"

ENV XPDF_VERSION=4.00

RUN apt-get -y update && \
    apt-get install -y \
    libfreetype6-dev \
    libopenjp2-7-dev \
    liblcms2-dev \
    libjpeg-dev \
    libtiff-dev && \
    rm -rf /var/lib/apt/list/* 

COPY build.sh /work/

RUN wget https://xpdfreader-dl.s3.amazonaws.com/xpdf-${XPDF_VERSION}.tar.gz && \
    tar xzvf xpdf-${XPDF_VERSION}.tar.gz && rm xpdf-${XPDF_VERSION}.tar.gz && \
    chmod a+x build.sh

ENV SRC=/work/xpdf-${XPDF_VERSION}

CMD ["/bin/bash"]



