FROM ubuntu:18.04

########################################################
# Essential packages for remote debugging and login in
########################################################
# Based on: https://github.com/shuhaoliu/docker-clion-dev
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    apt-utils \
    gcc \
    g++ \
    openssh-server \
    cmake \
    build-essential \
    gdb \
    gdbserver \
    rsync \
    gcc-multilib \
    qemu-system-common \
    qemu
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# 22 for ssh server. 7777 for gdb server.
EXPOSE 22 7777


# You may choose to use a different user by uncommenting the RUN lines
# User: xv6_docker
# Password: pwd
RUN useradd -ms /bin/bash xv6_docker
RUN echo 'xv6_docker:pwd' | chpasswd

########################################################
# Add custom packages and development environment here
########################################################

COPY /util/* /root/

########################################################

CMD ["/usr/sbin/sshd", "-D"]
