#!/usr/bin/env bash
set -eu

podman build -t metamath-wasm-build . 
cont=$(podman create metamath-wasm-build)
trap "podman rm $cont" EXIT
podman cp $cont:/work/metamath/metamath.wasm .
