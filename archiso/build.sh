#!/usr/bin/env bash

cd "$(dirname "$0")"
docker buildx build --progress=plain --load -t archiso:latest .
