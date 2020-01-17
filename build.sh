#!/usr/bin/env bash

# Check for dockerfile
if [[ -f ./Dockerfile ]]
then
    echo "Found Dockerfile"
else
    echo "Cannot find Dockerfile. Quitting..."
    exit 1
fi

# Create docker image
echo "Building docker image..."
docker build -t cs350 -f ./Dockerfile  . || exit $?

echo "Done!"
