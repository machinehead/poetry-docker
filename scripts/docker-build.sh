#!/usr/bin/env bash

set -uxeo pipefail

export BUILDKIT_PROGRESS=plain

# TODO: figure these args out
#  --build-arg BUILDKIT_INLINE_CACHE=1 \
#  --cache-from=type=local,src=/tmp/.buildkit-cache \
#  --cache-to=type=local,dest=/tmp/.buildkit-cache \

docker build \
  --progress=plain \
  --tag poetry \
  .
