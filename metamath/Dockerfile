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
RUN ./emsdk install 1.38.43
RUN ./emsdk activate 1.38.43
ENV PATH="/work/emsdk:${PATH}"
ENV PATH="/work/emsdk/node/14.15.5_64bit/bin:${PATH}"
ENV PATH="/work/emsdk/fastcomp/emscripten:${PATH}"
ENV EMSDK_NODE=/work/emsdk/node/14.15.5_64bit/bin/node
ENV EMSDK=/work/emsdk
ENV EM_CONFIG=/work/emsdk/.emscripten
RUN echo 'int main() {}' >/tmp/dummy.c \
	&& emcc /tmp/dummy.c -o /tmp/dummy.wasm
WORKDIR /work
RUN curl http://us.metamath.org/downloads/metamath.zip -o metamath.zip \
        && echo 126fc3eac6699257cfcdbfb2087fb31284fdfe784bb9d6e2ea7c32b8524c3da9 \ metamath.zip | sha256sum -c \
        && unzip metamath.zip -d . \
        && rm metamath.zip
WORKDIR /work/metamath
RUN emcc -O3 -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy *.c -o metamath.wasm
#RUN ln -s . wapm-builtin
#RUN emcc -O3 -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy $(for f in wapm-builtin/*.mm; do echo --embed-file $f; done) *.c -o metamath.wasm
