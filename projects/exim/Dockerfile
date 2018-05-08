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

RUN pip install -U setuptools && \
    pip install https://github.com/lief-project/packages/raw/lief-master-latest/pylief-${LIEF_VERSION}.dev.zip && \
    git clone https://github.com/Exim/exim.git && cd exim && \
    git reset --hard cf3cd306062a08969c41a1cdd32c6855f1abecf1~1 && cd src && mkdir Local && \
    cp src/EDITME Local/Makefile && cp exim_monitor/EDITME Local/eximon.conf && \
    sed -i 's/^EXIM_USER=/EXIM_USER=exim/' Local/Makefile &&  useradd exim && \
    FULLECHO='' LFLAGS+="-fsanitize=address -lasan -pie" \
    CFLAGS+="-fPIC -O1 -g -fsanitize=address" LDFLAGS+="-lasan -pie -ldl -lm -lcrypt" \
    LIBS+="-lasan -pie" make -e exim

COPY exe2so.py loader.cpp /work/

RUN cp exim/src/build-Linux-x86_64/exim exim && \
    python exe2so.py exim b64decode store_reset_3 && \
    clang-6.0 -DUSE_LIBFUZZER -O1 -g -fsanitize=fuzzer loader.cpp -no-pie -o fuzzer -ldl
