# CSCI 350 Operating Systems Image

Sections:

- [CSCI 350 Operating Systems Image](#csci-350-operating-systems-image)
  - [Intro](#intro)
  - [Image Contents](#image-contents)
  - [System Requirements](#system-requirements)
  - [Getting Started](#getting-started)
    - [Building the Image](#building-the-image)
    - [Working in the Environment](#working-in-the-environment)
    - [Stopping](#stopping)
  - [Debugging with CLion](#debugging-with-clion)
  - [Debugging in Docker](#debugging-in-docker)
  - [TODO](#todo)

## Intro

This repo is my attempt at creating a Docker image to do my operating systems development. After building the image, you should be able to use the `run.sh` script to start, stop, and work in a virtualized environment all from your command line!

Inspiration from [Noah Kim's](https://github.com/noahbkim) [cs104/docker](https://github.com/csci104/docker).

Here's what it looks like to interact with a setup environment:

[![asciicast](https://asciinema.org/a/308534.svg)](https://asciinema.org/a/308534)

NOTE: The `run.sh` script will only work on Unix systems. However, I've included notes for the exact commands you should run on a Windows system.

## Image Contents

You can test and build xv6 code in either a 32-bit or 64-bit environment. The `docker-compose.yml` builds from the `Dockerfile.remote-cpp-env` build file, that uses a 64-bit Ubuntu as a base image.

- `qemu` open source machine emulator and virtualizer for OS debugging
- `build-essential` for C support
- `gdb` for debugging, obviously
- `gcc-multilib` for 32-bit library support
- `xv6-public` a slimmed-down, simplified operating system based on UNIX v6
- `gcc` since we need C support, of course!
- `rsync` and `openssh-server` to sync with IDE's like CLion and easily connect to the environment
- `cmake` for configurable makefile support

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

First, **install Docker** desktop from [the website](https://www.docker.com/products/docker-desktop).
Once done, **clone this repository**.

### Building the Image

Building the image should require two steps.

1. specify your desired mount location (i.e. your `xv6` project folder)
2. build the image



**Unix-based Users**: 

1. Modify the `run.sh` file's `work` variable at the top of the file to be your project folder.
For example:

```shell
work=~/projects/cs350/xv6-public-master/
```

2. Run the `run.sh` script will check if you've built an image yet, then either
build and start or just start the container:

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

2. Run this command to build the environment:

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

## Debugging with CLion

You can use the Docker image for building and debugging while working on your favorite IDE on your local machine. This tutorial will go through setting things up with CLion, a Jetbrains IDE that you have a license to use as a student. Download it [here](https://www.jetbrains.com/clion/download/).

I'm grateful to [Jamie Smith](https://github.com/multiplemonomials) for setting up a CMake config for the xv6 assignments. You'll need to download the corresponding xv6-clion files [from Piazza](https://piazza.com/class/k54geyf9w235qb?cid=28) and place them in the `xv6-public-master` directory. Please follow his setup guide to setup CLion.

Next, we will setup a toolchain and remote debugging configuration with the **running** Docker image. Make sure you execute `./run.sh start` for the next steps to work.

1. Create a new `GDB Remote Debug` configuration

Open `Preferences` and search or `Edit Configurations` and select the option.

2. Set configuration settings below

- `GDB`: Bundled GDB multiarch (may need to install `gdb` locally)
- 'target remote' args: `localhost:25000`
- Symbol file: `/YOUR-PATH/xv6-public-master/kernel`
- Sysroot: `/YOUR-PATH/xv6-public-master`
- Path Mappings (Remote to Local): `/xv6_docker/` to `/YOUR-PATH/xv6-public-master`

Your finished configuration should look something like this:

![debug_config](https://i.imgur.com/IzfggMx.png)

1. Setup your terminal in the IDE (optional)

Unfortunately, I don't yet have a way to seamlessly integrate the debugging environment with CLion. However, this following method is still fairly easy to setup. Open a terminal window in CLion and move to the `cs350-docker` folder. You might want to split the terminal screen on the bottom with the debugger window. You can adjust the window's position with the gear icon on the top right of a window.

![terminal](https://i.imgur.com/gn0kmsd.png)

1. (In Docker) run `make qemu-nox-gdb`

Make sure you're in a Docker shell and run the command to start a `gdb` session.

5. (In Clion) Set a breakpoint in the code (optional)

6. (In CLion) Start a remote debugging session

Make sure the configuration you made in `2` is selected and click the green bug icon:

![debug](https://i.imgur.com/Yu2CtXq.png)

It might take a while, but a Debug window will open in CLion and show you some very useful information about variables and registers!

![debugging](https://i.imgur.com/cy9L6Qz.png)

## Debugging in Docker

Here's a quick example of how you can use GDB with the Docker image. I'm using tmux in this video, but you can 
use any method to have multiple terminals.

[![](http://img.youtube.com/vi/mkTIOiGpykg/0.jpg)](http://www.youtube.com/watch?v=mkTIOiGpykg "gdb with xv6")

Here's the step-by-step:

Terminal A, B should be in the xv6-public-master directory:

*Terminal A:*
1. run: `make qemu-nox-gdb`
2. note the port number (here it was 25000)

*Terminal B:*

1. run: `gdb kernel`
2. (optional) set breakpoints in the source code
3. run: `c` (continue)
4. start debugging!

(optional)
*Terminal A:*
1. run any user-level program

*Terminal B:*
1. Ctrl-C
2. `bt` (backtrace)

## TODO

- [x] actually finish writing Dockerfile
- [x] write build/run/stop script
- [ ] finish writing instructions
