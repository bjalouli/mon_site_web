#!/bin/bash

if [ -z "$3" ]; then
    echo "usage: deliver workspace build-id git-commit"
    exit 1
fi

workspace="$1"
build_id="$2"
git_commit="$3"
deliver_dir="/path/to/deliver/directory/$build_id"

if [ -d "$deliver_dir" ]; then
    echo "ERROR: Deliver directory $deliver_dir already exists"
    exit 1
fi

mkdir "$deliver_dir" || { echo "ERROR: Cannot create directory $deliver_dir"; exit 1; }

cd "$deliver_dir" || { echo "ERROR: Failed to change directory to $deliver_dir"; exit 1; }

echo "Jenkins build id: $build_id" > meta.txt
echo "Git commit: $git_commit" >> meta.txt
echo "Last 5 commits..." >> meta.txt
echo "" >> meta.txt
git -C "$workspace" log --format=medium -5 >> meta.txt

mkdir Debug
cp "$workspace/Debug/"*.bin Debug
cp "$workspace/Debug/"*.map Debug
cp "$workspace/Debug/"*.list Debug

mkdir Release
cp "$workspace/Release/"*.bin Release
cp "$workspace/Release/"*.map Release
cp "$workspace/Release/"*.list Release
