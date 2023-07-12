#!/usr/bin/env bash

set -eu
cd "$(dirname "$0")"

CARGO_BUILD_TARGET=wasm32-wasi \
CARGO_TARGET_DIR="$PWD/target" \
cargo build --release --manifest-path=src/crates/ruff_cli/Cargo.toml

wasm-strip target/wasm32-wasi/release/ruff.wasm
wasm-opt -O4 target/wasm32-wasi/release/ruff.wasm -o pack/ruff
