# CSCI 350 Operating Systems Image

## Intro

This repo contains a simple dev environment to do operating system development
(at least for xv6). After pulling the Docker image from
[camerondurham/xv6-docker](https://github.com/camerondurham/xv6-docker), you
should be able to use the `run.sh` script to start, stop, and work in a
virtualized environment all from your command line.

Inspiration from [Noah Kim's](https://github.com/noahbkim) [cs104/docker](https://github.com/csci104/docker).

Here's what it looks like to interact with a setup environment:

[![asciicast](https://asciinema.org/a/308534.svg)](https://asciinema.org/a/308534)

NOTE: The `run.sh` script will only work on Unix systems. However, I've included notes for the exact commands you should run on a Windows system.

To see what's in the Docker image, see: [camerondurham/xv6-docker](https://github.com/camerondurham/xv6-docker)

For more information, please see the [wiki](https://github.com/camerondurham/cs350-docker/wiki). If you have questions, you can email me at:
cameronrdurham@gmail.com


## Sections

- [CSCI 350 Operating Systems Image](#csci-350-operating-systems-image)
  - [System Requirements](#system-requirements)
  - [Getting Started](#getting-started)
    - [Building the Image](#building-the-image)
    - [Working in the Environment](#working-in-the-environment)
    - [Stopping](#stopping)
  - [TODO](#todo)

## System Requirements

Below are the system requirements for Docker Desktop:

[Windows host](https://docs.docker.com/docker-for-windows/install/):

- Windows 10 64-bit: Pro, Enterprise, or Education (Build 15063 or later).
- Hyper-V and Containers Windows features must be enabled.

If you are using Windows 10 Home, you can obtain a "free" license for Windows 10 Education [here](https://viterbiit.usc.edu/services/hardware-software/microsoft-imagine-downloads/).

[Mac host](https://docs.docker.com/docker-for-mac/install/):

- Mac hardware must be a 2010 or newer model
- macOS must be version 10.13 or newer
- 4 GB RAM minimum

## Getting Started


### Set Up

1. **install Docker** desktop from [the website](https://www.docker.com/products/docker-desktop)

2. **clone this repository**.

3. specify your desired mount location (i.e. your `xv6` project folder)

**Unix-based Users**:

1. Modify the `run.sh` file's `work` variable at the top of the file to be your project folder.
For example:

```shell
work=~/projects/cs350/xv6-public-master/
```

2. Run the `run.sh` script. If this is your first time starting, this will
pull the Docker image. This image will be cached until there's a new image
available or you manually remove it.

```shell
./run.sh start
```

This script is only a wrapper for some simple Docker commands.

**Windows Users**: I need to still write some support for volume mounting. For now, please follow these steps:

1. In `docker-compose.yml`, change line below the `volumes` rule to mount your desired project folder.

For example, change this:

```yml
    volumes:
        - ${work}:/xv6_docker/
```

to this:

```yml
    volumes:
        - C:\Username\xv6-public-master:/xv6_docker/
```

2. Run this command to start the environment:

```shell
docker-compose up -d
```

### Working in the Environment

To start up a Linux shell inside the Docker image, you'll want to start a terminal session inside the Docker image:

**Unix-based Users**:

```shell
./run.sh shell
```

**Windows Users**:

```shell
docker exec -it xv6_docker /bin/bash
```

### Stopping

After you're done working in the environment, you might want to shut down the image. Don't worry if you forget to
do this, since Docker Desktop will automatically and safely stop running images when you shutdown your computer.

**Unix-based Users**:

```shell
./run.sh stop
```

**Windows Users**:

```shell
docker-compose down
```

## TODO

- [x] actually finish writing Dockerfile
- [x] write build/run/stop script
- [ ] finish writing instructions
- [ ] write run script for Windows users
