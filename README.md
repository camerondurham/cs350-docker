# CSCI 350 Operating Systems Image

This repo is my attempt at creating a Docker image to do my operating systems
development. Inspiration from [cs104/docker](https://github.com/csci104/docker).

Current status: the image builds `xv6-public` without errors after running
`./build32.sh` or `./build64.sh` and mounting the `xv6-public` as a volume.
I've only included the xv6-public folder for testing purposes for anyone
apprehensive about this Docker environment working.

## Image Contents

You may choose between a 32-bit image or a 64-bit Docker image. Either will
work with xv6.

- `qemu` open source machine emulator and virtualizer for OS debugging
- `build-essential` for C support
- `gdb` for debugging, obviously
- `gcc-multilib` for 32-bit library support
- `xv6-public` a slimmed-down, simplified operating system based on UNIX v6


## Getting Started


To start working on homework, you can run the following command. This
will mount a folder into the image and use the running container's name
tagged in the previous command. Start the interactive terminal in the
directory `/root` running bash. This will only work after running
the build script `./build32.sh`.

```shell
# start 32-bit cs350_32 docker image in cs350 directory
docker run -it -v "$HOME/projects/cs350-docker/":/root -w /root cs350_32 /bin/bash

# start 64-bit cs350_64 docker image in cs350 directory
docker run -it -v "$HOME/projects/cs350-docker/":/root -w /root cs350_64 /bin/bash
```

## Docker Commands for Reference

```shell
# create image from source code and Dockerfile
# this is what build.sh will do for you
docker build <directory>
docker build .

# run docker container interactively
docker run -it <CONTAINER NAME> <WHAT TO RUN>
docker run -it linux-box /bin/bash
```

About the following command, which you should use to run the image:

- `-v /path/to/material/:/root/` mounts the work folder on our machine to `/root` in the container
- `-d` runs the container in the background
- `-t` allocates a command prompt for us to access when we interact with the container
- `--cap-add SYS_PTRACE` will allow GDB to correctly access executable runtimes
- `--security-opt seccomp=unconfined` allows memory allocation and debugging to work correctly
- `--name <NAME>` gives the container a name to reference in other docker commands


How to run the image:

```bash
# start the image running in the background
docker run -v <PATH TO DEV FOLDER>:/root/ -dt --cap-add SYS_PTRACE --security-opt seccomp=unconfined --name cs350 cs350_<32 OR 64>

# start the image and run interactively for gdb access in the current working directory
docker run -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined  -v "$(pwd)":/root -w /root cs350 /bin/bash
```

To make it easier, I added these aliases to my `.bashrc`

```shell
oshere='docker run -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined  -v "$(pwd)":/root -w /root cs350 /bin/bash'

osup='docker run -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined  -v "$HOME/projects/cs350/":/root -w /root cs350 /bin/bash'

```

## TODO

- [x] actually finish writing Dockerfile
- [x] write rudimentary build script to create docker image
- [ ] finish writing instructions

