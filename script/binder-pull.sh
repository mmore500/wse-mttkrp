#!/usr/bin/env bash

cd "$(dirname "$0")/../binder"

for f in *; do (git -C $f pull origin $f &); done

wait
