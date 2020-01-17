# CSCI 350 Operating Systems Image

This repo is my attempt at creating a Docker image to do my operating systems
development. Inspiration from [cs104/docker](https://github.com/csci104/docker).

Current status: the image builds `xv6-public` without errors after running
`./build.sh` and mounting the `xv6-public` as a volume.

## Image Contents

This image is based on a 32-bit image required for this class. I'm using
`32bit/ubuntu` from Docker Hub.

- `qemu` open source machine emulator and virtualizer for OS debugging
- `build-essential` for C support
- `gdb` for debugging, obviously
- `gcc-multilib` for 32-bit library support
- `xv6-public` a slimmed-down, simplified operating system based on UNIX v6



## Getting Started


To start working on homework, you can run the following command. This
will mount a folder into the image and use the running container's name
tagged in the previous command. Start the interactive terminal in the
directory `/home/work/` running bash. This will only work after running
the build script `./build.sh`.

```shell
# start cs-104 docker image in cs104 directory
docker run -it -v "$HOME/projects/cs350-docker/":/home/work -w /home/work/ cs350 /bin/bash
```

## Docker Commands

```shell
# create image from source code and Dockerfile
docker build <directory>
docker build .

# run docker container interactively
docker run -it <CONTAINER NAME> <WHAT TO RUN>
docker run -it linux-box /bin/bash
```

About the following command, which you should use to run the image:

- `-v /path/to/material/:/work/` mounts the work folder on our machine to `/work` in the container
- `-d` runs the container in the background
- `-t` allocates a command prompt for us to access when we interact with the container
- `--cap-add SYS_PTRACE` will allow GDB to correctly access executable runtimes
- `--security-opt seccomp=unconfined` allows memory allocation and debugging to work correctly
- `--name <NAME>` gives the container a name to reference in other docker commands

```bash
docker run -v <PATH TO DEV FOLDER>:/work/ -dt --cap-add SYS_PTRACE --security-opt seccomp=unconfined --name cs350 cs350
```


## TODO

- [x] actually finish writing Dockerfile
- [x] build script to create docker image
- [ ] finish writing instructions
