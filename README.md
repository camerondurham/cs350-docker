# CSCI 350 Operating Systems Image

This repo is my attempt at creating a Docker image to do my operating systems
development. Inspiration from [cs104/docker](https://github.com/csci104/docker).

## Image Contents

This image is based on a 32-bit image required for this class. I'm using
`32bit/ubuntu` from Docker Hub.

- `qemu` open source machine emulator and virtualizer for OS debugging
- `build-essential` for C support
- `gdb` for debugging, obviously
- `gcc-multilib` for 32-bit library support
- `xv6-public` a slimmed-down, simplified operating system based on UNIX v6


## Docker Commands

```shell
# create image from source code and Dockerfile
docker build <directory>
docker build .

# run docker container interactively
docker run -it <CONTAINER NAME> <WHAT TO RUN>
docker run -it linux-box /bin/bash
```

## TODO

- [ ] actually finish writing Dockerfile
- [ ] build script to create docker image
