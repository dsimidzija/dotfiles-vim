#!/bin/bash

git submodule foreach git checkout master
git submodule foreach git pull
git submodule foreach git submodule update --init --recursive
