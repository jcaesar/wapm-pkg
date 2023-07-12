#!/usr/bin/env bash

set -eu
cd "$(dirname "$0")"

rm -rf src src.tar.gz
http -d -o src.tar.gz https://crates.io/api/v1/crates/schermz/0.1.11/download
mkdir src
tar xvf src.tar.gz -C src --strip-components=1 

CARGO_BUILD_TARGET=wasm32-wasi \
CARGO_TARGET_DIR="$PWD/target" \
cargo build --release --manifest-path=src/Cargo.toml

wasm-strip target/wasm32-wasi/release/schermz.wasm
wasm-opt -O4 target/wasm32-wasi/release/schermz.wasm -o pack/schermz
