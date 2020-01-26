#!/usr/bin/env bash

# Check for dockerfile
if [[ -f ./64-bit/Dockerfile ]]
then
    echo "Found Dockerfile"
else
    echo "Cannot find Dockerfile. Quitting..."
    exit 1
fi

# Create docker image
echo "Building 32-bit docker image..."
docker build -t cs350_32 -f ./32-bit/Dockerfile  . || exit $?

echo "Done!"
