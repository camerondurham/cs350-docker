FROM ubuntu:18.04

# For testing purposes, not required
# since you'll be mounting your own xv6 homework folders
# RUN mkdir /home/xv6-test
# COPY xv6-public/* /home/xv6-test/

# Container setup for building C programs
RUN apt-get update
RUN apt-get install -y  build-essential \
                        gdb \
                        gcc-multilib \
                        qemu-system-common \
                        qemu

# Add bashrc with sligtly better prompt
COPY ./util/* /root/
