#!/bin/bash
rm -rf modpack
git clone "$1" modpack
cd modpack
git submodule update --init --recursive
chmod +x prepare.sh
./prepare.sh
#find ./ -name '*.url.txt' -delete
