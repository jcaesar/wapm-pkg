#!/usr/bin/env bash

set -eu
cd "$(dirname "$0")/$1"

CARGO_BUILD_TARGET=wasm32-wasi \
CARGO_TARGET_DIR="$PWD/target" \
cargo build --release --manifest-path=src/"$2"Cargo.toml

wasm-strip target/wasm32-wasi/release/"$3".wasm
wasm-opt -O4 target/wasm32-wasi/release/"$3".wasm -o pack/"$3"
