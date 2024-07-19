#!/bin/bash

export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=r
export ARCH=arm64

make -j$(nproc) 
