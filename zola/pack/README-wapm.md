# [Zola](https://www.getzola.org/) modified for WASM by [dstaley](https://github.com/dstaley/zola/tree/wasm)

Usage:
```bash
cd to_your_zola_page
wasmer run https://wapm.io/liftm/zola --dir=. -- --root=/ build
```

(Note that you may have to delete `public/` manually beforehand due to [#3575](https://github.com/wasmerio/wasmer/issues/3575).)
