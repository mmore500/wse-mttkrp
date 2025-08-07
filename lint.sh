#!/bin/bash

set -e

ruff --ignore=E501,E402 $@ .
python3 -m nbqa ruff --ignore=E501,E402 $@ .
