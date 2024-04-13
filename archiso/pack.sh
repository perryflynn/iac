#!/usr/bin/env bash

cd "$(dirname "$0")"
rm -rf output
mkdir -p output

docker run --rm -it --privileged --name archiso -v "$(pwd)/output:/output" archiso:latest
