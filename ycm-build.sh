#!/bin/bash

cd youcompleteme/
git submodule update --init --recursive
./install.py --system-libclang --clang-completer --go-completer --js-completer
cd -
