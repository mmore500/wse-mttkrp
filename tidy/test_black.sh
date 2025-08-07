#!/bin/bash
set -e

# enforce use of GNU version of coreutils
. ./tidy/util/enforce_gnu_utils.sh

SOURCE_HASH=$( find -path ./cpp/third-party -prune -false -o -type f | sort | xargs cat | sha1sum )

# ignore notebooks
black **/*.py

if [ "${SOURCE_HASH}" == "$( find -path ./cpp/third-party -prune -false -o -type f | sort | xargs cat | sha1sum )" ];
then
  exit 0 # success
else
  echo "black violations detected, run black locally to find & fix"
  exit 1 # failure
fi
