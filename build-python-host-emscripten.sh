#!/bin/env bash

export PYTHON_FOR_BUILD="$(pwd)/cpython-build/python"

cd cpython-host

cp ../config.site-wasm config.site-wasm
CONFIG_SITE=config.site-wasm READELF=true emconfigure ./configure -C --without-pymalloc --enable-big-digits=30 --with-pydebug --with-suffix=.wasm --with-ensurepip=no --disable-ipv6 --disable-shared --host=wasm32-unknown-emscripten --build=x86_64-unknown-linux-gnu
ln -sfr Modules/Setup.stdlib Modules/Setup.local
emmake make CROSS_COMPILE=yes FREEZE_MODULE=../cpython-build/Programs/_freeze_module _PYTHON_HOST_PLATFORM=wasm32-unknown-emscripten -j