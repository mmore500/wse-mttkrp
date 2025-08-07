#!/bin/bash

set -e

cd "$(dirname "$0")"

if ! python3 -m pip freeze | grep -q "black==";
then
    echo "black formatter is not installed!"
    echo "aborting"
    exit 1
elif ! grep -q "$(python3 -m pip freeze | grep "black==")" requirements.txt; then
    echo "incorrect black version installed"
    echo "has $(python3 -m pip freeze | grep "black==")"
    echo "needs $(cat requirements.txt | grep "black==")"
    echo "aborting"
    exit 1
fi


python3 -m black .
python3 -m isort .
python3 -m nbqa black .
python3 -m nbqa isort .
