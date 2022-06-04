FROM debian:bookworm
RUN apt-get update && apt-get install -y wget patch libxml2 && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
RUN wget --progress=dot:mega https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-15/wasi-sdk-15.0-linux.tar.gz -O wasi-sdk.tgz \
  && echo 9b1f2c900a034a44e59b74843cd79b4f189342598e554029367ef0a2ac286703 \ wasi-sdk-15.0-linux.tar.gz \
  && tar xvf wasi-sdk.tgz \
  && rm wasi-sdk.tgz \
  && mv wasi-sdk-* wasi-sdk
ENV WASI_SDK_PATH=/opt/wasi-sdk 
WORKDIR /opt/sam
COPY src/. .
COPY patch /work/metamath.patch
RUN patch -p1 </work/metamath.patch
RUN /opt/wasi-sdk/bin/clang --sysroot=/opt/wasi-sdk/share/wasi-sysroot \
	-Wall -flto -O3 -o sam.wasm \
	src/reciter.c src/sam.c src/render.c src/main.c src/debug.c
	
