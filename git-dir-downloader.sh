#!/bin/bash

if [ "$#" -ne 2 ]; then
  exit 1
fi

repoUrl=$1
dirPath=$2

tempDir=$(mktemp -d)

git clone --filter=blob:none --no-checkout "$repoUrl" "$tempDir"

cd "$tempDir"

git sparse-checkout init --cone

echo "$dirPath" >.git/info/sparse-checkout

git checkout

if [ -d "$dirPath" ]; then
  mv "$dirPath"/* "$OLDPWD"
else
  exit 1
fi

cd "$OLDPWD"

rm -rf "$tempDir"
