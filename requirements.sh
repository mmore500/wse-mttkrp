#!/usr/bin/bash

set -e

cd "$(dirname "$0")"
python3 -m uv pip compile requirements.in > requirements.txt
