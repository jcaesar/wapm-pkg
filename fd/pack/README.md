# fd

A WASI adoption of [fd](https://github.com/bootandy/fd), a simple, fast and user-friendly alternative to find.

WASI does not (yet?) provide all the operating system level access a tool like fd requires, so:
* Performance is degraded for running single-threaded
* Output is not colored
* Executing commands on the found files is not possible

You'll still benefit from its nice interface.
