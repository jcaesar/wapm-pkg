#!/usr/bin/env bash

set -euo pipefail
set -x

D="$(realpath "$(dirname "$0")")" # TODO: check for whitespace...
SYSROOT=--sysroot=${WASI_SYSROOT-/usr/share/wasi-sysroot}
CFLAGS="$SYSROOT -D_WASI_EMULATED_SIGNAL -DDOCTEST_CONFIG_NO_EXCEPTIONS -DDOCTEST_CONFIG_NO_EXCEPTIONS_BUT_WITH_ALL_ASSERTS -D_WASI_EMULATED_PROCESS_CLOCKS -include $D/wasi-stubs.h"
CXXFLAGS="$CFLAGS -fno-exceptions -D_NO_EXCEPTIONS"
cmake -S "$D/src" -B "$D/build" \
	-DCMAKE_C_COMPILER_TARGET=wasm32-wasi \
	-DCMAKE_CXX_COMPILER_TARGET=wasm32-wasi \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_CXX_COMPILER=clang++ \
	"-DCMAKE_C_FLAGS=$CFLAGS" \
	"-DCMAKE_CXX_FLAGS=$CXXFLAGS" \
	"-DCMAKE_EXE_LINKER_FLAGS=$SYSROOT -lwasi-emulated-signal -lwasi-emulated-process-clocks" \

cmake --build "$D/build" --parallel
