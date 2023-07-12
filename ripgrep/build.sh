#!/usr/bin/env bash

exec "$(dirname "$0")/../build-rust-generic.sh" ripgrep "" rg
