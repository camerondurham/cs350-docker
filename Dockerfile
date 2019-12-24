FROM ubuntu:18.04

# Container setup with xv6
RUN apt-get update
RUN apt-get install -y build-essential gdb
RUN apt-get install gcc-multilib qemu
