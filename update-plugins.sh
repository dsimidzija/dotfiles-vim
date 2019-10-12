#!/bin/bash

git submodule init
git submodule update
git submodule foreach git checkout master
git submodule foreach git pull
git submodule foreach git submodule init
git submodule foreach git submodule sync --recursive
git submodule foreach git submodule update --recursive
