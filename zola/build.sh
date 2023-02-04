env CFLAGS_wasm32_wasi=--sysroot=/usr/share/wasi-sysroot/ cargo build --target wasm32-wasi --no-default-features --features indexing-zh,indexing-ja --release
