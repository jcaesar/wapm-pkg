#!/usr/bin/env bash
set -eu

podman build -t sam-wasm-build . 
cont=$(podman create sam-wasm-build)
trap "podman rm $cont" EXIT
podman cp $cont:sam.wasm .
