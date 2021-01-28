# exa

An adaption of [exa](https://github.com/ogham/exa), "a modern replacement for ls", for wasi.

It can be done, that's why exists
It doesn't mean it's a good idea for it to exist.

The main reason this is not a good idea is that wasi does not expose much of the typical information you'd expect to find in the output of `ls` or `exa`. I have not spent any effort to remove the fields like owner or permissions either, and they'll simply appear zeroed out.
