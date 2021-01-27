#!/usr/bin/env bash

set -euo pipefail

df='
FROM docker.io/library/ubuntu:18.04
RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -yq \
        build-essential \
        clang \
        cmake \
        curl \
        emscripten \
        file \
        git \
        sudo \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV PATH=/root/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly --profile minimal --no-modify-path && \
    rustup target add wasm32-wasi && \
    rustup target add wasm32-unknown-emscripten
WORKDIR /root/src
'

# Good part about podman? no need to worry about PIDs and file owners.
# Bad part? Build cache is dead slow...
dfh=$(sha256sum <<<"$df" - | cut -d\  -f1)
tag=rust-wasi-builder-$dfh
if ! podman image list --format "{{.Repository}}" | grep -q $tag; then
	podman build -t $tag - <<<"$df"
fi

target="$(realpath "${1?"No target folder parameter"}")"

mkdir -p "$target/target" cache

podman run --rm -ti \
	-e http_proxy="${podman_http_proxy:-${http_proxy:-}}" \
	-e https_proxy="${podman_https_proxy:-${https_proxy:-}}" \
	-v "$target/src:/root/src" \
	-v "$target/target:/root/src/target" \
	-v "$(realpath "$(dirname "$0")")/cache:/root/.cargo/registry" \
	$tag cargo build -v --release --locked --target=wasm32-wasi
	# Sad that this won't work: cargo +nightly build -Z build-std=core,std,alloc --release --locked --target=wasm32-wasi

mkdir -p "$target/pack"
cp  -t "$target/pack/" "$target"/target/wasm32-wasi/release/*.wasm
