FROM ubuntu:16.04

LABEL maintainer="junchaoluan@gmail.com"

ENV LLVM_VERSION=4.0

RUN apt-get update && \
    apt-get install -y \
    cmake \
    g++ \
    llvm-${LLVM_VERSION} \
    clang-${LLVM_VERSION} \
    automake \
    pkg-config \
    libtool \
    gdb \
    git \
    wget \
    ltrace \
    strace \
    python-pip && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${LLVM_VERSION} 60 \
	--slave /usr/bin/clang++ clang++ /usr/bin/clang++-${LLVM_VERSION} \
	--slave /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-${LLVM_VERSION} && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /work/

RUN wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && \
	tar xzvf afl-latest.tgz && \
	cd afl-* && make && \
	cd llvm_mode && make && cd .. && make install && \
	cd ../ && rm -rf afl-*
