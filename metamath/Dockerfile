FROM docker.io/library/debian:bullseye as bin
RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -yq \
        build-essential \
        cmake \
        curl \
        file \
        git \
        python3 \
        python \
        sudo \
        unzip \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd frust --user-group --create-home --home-dir /work --shell /bin/bash
USER frust
WORKDIR  /work
RUN git clone https://github.com/emscripten-core/emsdk.git
WORKDIR /work/emsdk
RUN ./emsdk install 2.0.31
RUN ./emsdk activate 2.0.31
ENV PATH="/work/emsdk/node/14.15.5_64bit/bin:${PATH}"
ENV PATH="/work/emsdk/upstream/emscripten:${PATH}"
ENV PATH="/work/emsdk:${PATH}"
ENV EMSDK_NODE=/work/emsdk/node/14.15.5_64bit/bin/node
ENV EMSDK=/work/emsdk
ENV EM_CONFIG=/work/emsdk/.emscripten
RUN echo 'int main() {}' >/tmp/dummy.c \
	&& emcc /tmp/dummy.c -o /tmp/dummy.wasm
WORKDIR /work
RUN curl -sLS https://github.com/metamath/metamath-exe/archive/refs/tags/v0.198.tar.gz -o metamath.tgz \
        && echo 7029880b754ee7e7e97b4c1b5e79910222c4f258d353e9b739dc413a4f35551f \ metamath.tgz | sha256sum -c \
        && tar xvf metamath.tgz \
        && rm metamath.tgz \
	&& mv metamath-* metamath
WORKDIR /work/metamath
COPY api-reduce.patch .
RUN patch -p1 <api-reduce.patch
RUN emcc -O1 -g3 -s STANDALONE_WASM=1 -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy *.c -o metamath.wasm
#RUN ln -s . wapm-builtin
#RUN emcc -O3 -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy $(for f in $(find wapm-builtin/ -name *.mm); do echo --embed-file $f; done) *.c -o metamath.wasm
