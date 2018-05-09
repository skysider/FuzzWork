FROM skysider/fuzzwork:base_libfuzzer
LABEL maintainer=skysider@163.com

ENV LIEF_VERSION 0.8.3

RUN apt-get -y update && \
    apt-get install -y \
    gcc \
    git \
    make \
    libpcre++-dev \
    libdb-dev \
    libperl-dev \
    libxt-dev \
    libxaw7-dev \
    python \
    python-pip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY exe2so.py build.sh /work/

RUN pip install -U setuptools && \
    pip install https://github.com/lief-project/packages/raw/lief-master-latest/pylief-${LIEF_VERSION}.dev.zip && \
    git clone https://github.com/Exim/exim.git && chmod +x build.sh && ./build.sh

RUN cp exim/src/build-Linux-x86_64/exim exim2 && \
    python exe2so.py exim2 b64decode store_reset_3 && mv exim2.so exim.so && \
    clang -DUSE_LIBFUZZER -O1 -g -fsanitize=fuzzer loader.cpp -no-pie -o fuzzer -ldl
