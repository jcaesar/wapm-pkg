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
ENV WASI_VERSION=12
ENV WASI_VERSION_FULL=${WASI_VERSION}.0
ENV WASI_HASH=fa47694d75bf6fce98fbe7927193298b25ee03dade27fca453d7dd530378973a
RUN curl -sLS https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-$WASI_VERSION/wasi-sdk-$WASI_VERSION_FULL-linux.tar.gz -o wasi-sdk.tgz \
	&& echo $WASI_HASH \ wasi-sdk.tgz | sha256sum -c \
	&& tar xvf wasi-sdk.tgz \
	&& rm wasi-sdk.tgz
ENV WASI_SDK_PATH=/work/wasi-sdk-${WASI_VERSION_FULL}
ENV CC="${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot"
RUN curl -sLS https://github.com/metamath/metamath-exe/archive/refs/tags/v0.198.tar.gz -o metamath.tgz \
        && echo 7029880b754ee7e7e97b4c1b5e79910222c4f258d353e9b739dc413a4f35551f \ metamath.tgz | sha256sum -c \
        && tar xvf metamath.tgz \
        && rm metamath.tgz \
	&& mv metamath-* metamath
WORKDIR /work/metamath
COPY patch /work/metamath.patch
RUN patch -p1 </work/metamath.patch
RUN $CC *.c -o metamath.wasm
