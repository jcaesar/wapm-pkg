# [UPX](https://www.getzola.org/) modified for WASM

Usage:
```bash
wasmer run https://wapm.io/liftm/upx --dir=. -- ./some-exe -o ./some-exe-compressed
chmod a+x ./some-exe-compressed # wasi can't do anything about permissions
```
