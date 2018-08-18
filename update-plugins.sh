#!/bin/bash

git submodule foreach git checkout master
git submodule foreach git pull
git submodule foreach git submodule --init --recursive
git submodule foreach git submodule update --recursive
