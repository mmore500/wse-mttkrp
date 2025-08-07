#!/usr/bin/env bash

# Clean up and prepare the tracking directory
rm -rf /tmp/gitgc.sh
mkdir -p /tmp/gitgc.sh

# Count total number of submodules
total_submodules=$(git submodule foreach --recursive 'echo' | wc -l)
completed=0

echo "Info: pass --aggressive --prune=now for deeper scrub"
echo "Starting garbage collection for $total_submodules submodules..."

# Garbage collection for each submodule
git submodule foreach --recursive '
    (git gc $@ && touch "/tmp/gitgc.sh/$(basename "$PWD")" && echo "$PWD complete") &
'

echo "Waiting for all background jobs to finish..."

# Loop to monitor progress
while [ $(ls /tmp/gitgc.sh | wc -l) -lt $total_submodules ]; do
    completed=$(ls /tmp/gitgc.sh | wc -l)
    remaining=$((total_submodules - completed))
    echo "Jobs completed: $completed, Jobs remaining: $remaining"
    sleep 5  # Update every 5 seconds
done

echo "Entering final wait..."
wait

echo "Garbage collection complete for all submodules."
