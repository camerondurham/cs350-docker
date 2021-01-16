# CSCI 350 Operating Systems Image

<a href="https://hub.docker.com/repository/docker/camerondurham/cs350-docker">
  <img align="left" src="https://img.shields.io/docker/image-size/camerondurham/cs350-docker?style=flat-square" />
</a>

<a href="https://hub.docker.com/repository/docker/camerondurham/cs350-docker">
  <img align="left" src="https://img.shields.io/docker/pulls/camerondurham/cs350-docker" />
</a>

<a href="https://github.com/marketplace/actions/super-linter">
  <img align="left" src="https://github.com/camerondurham/cs350-docker/workflows/Lint%20Code%20Base/badge.svg" />
</a>

<br>

## Intro

This repo contains a simple dev environment to do operating system development
(at least for xv6). After pulling the Docker image from Docker Hub, you
should be able to use the `run.sh` script to start, stop, and work in a
virtualized environment all from your command line.

Inspiration from [Noah Kim's](https://github.com/noahbkim) [cs104/docker](https://github.com/csci104/docker).

Here's what it looks like to interact with a setup environment:

[![asciicast](https://asciinema.org/a/308534.svg)](https://asciinema.org/a/308534)

> Update: a Windows PowerShell script has been added

This repository's Dockerfile is the Docker image pulled from Docker Hub.

For more information, please see the [wiki](https://github.com/camerondurham/cs350-docker/wiki). If you have questions, you can email me at:
cameronrdurham@gmail.com


## Sections

- [CSCI 350 Operating Systems Image](#csci-350-operating-systems-image)
  - [Intro](#intro)
  - [Sections](#sections)
  - [System Requirements](#system-requirements)
  - [Getting Started](#getting-started)
    - [Set Up](#set-up)
    - [Running](#running)
    - [Working in the Environment](#working-in-the-environment)
    - [Stopping](#stopping)

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


**Windows users only**

Make sure you run this in an Admin PowerShell to let you run scripts:

```powershell
# must execute this in admin powershell and select [A] to run scripts
Set-ExecutionPolicy RemoteSigned
```

### Running

1. Modify the `work` variable at the top of the run script in the project folder.
For example:

**macOS/Linux**

```bash
# in run.sh
work=~/projects/cs350/xv6-public-master/
```

**Windows**

```powershell
# in run.ps1
$work="C:\Users\Username\cs350\xv6-public-master"
```

2. Run the `run.sh`/`run.ps1` script. If this is your first time starting, this will
pull the Docker image. This image will be cached until there's a new image
available or you manually remove it.

**macOS/Linux**

```bash
./run.sh start
```

**Windows**

```powershell
.\run.ps1 start
```

This script is only a wrapper for some simple Docker commands.


### Working in the Environment

To start up a Linux shell inside the Docker image, you'll want to start a terminal session inside the Docker image:

**Unix-based Users**:

```shell
./run.sh shell
```

**Windows Users**:

```powershell
.\run.ps1 shell
```

### Stopping

After you're done working in the environment, you might want to shut down the image. Don't worry if you forget to
do this, since Docker Desktop will automatically and safely stop running images when you shutdown your computer.

**Unix-based Users**:

```shell
./run.sh stop
```

**Windows Users**:

```powershell
.\run.ps1 stop
```
