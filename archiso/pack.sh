#!/usr/bin/env bash

cd "$(dirname "$0")"
rm -rf output
mkdir -p output
mkdir -p pacman-cache

extraargs=()
if [ -f ../.env ]; then
    extraargs+=( --env-file "$(realpath "$(pwd)/../.env")" )
fi

docker run --rm -it --privileged \
    --name archiso \
    -v "$(pwd)/output:/output" \
    -v "$(pwd)/pacman-cache:/var/cache/pacman" \
    "${extraargs[@]}" \
    archiso:latest
