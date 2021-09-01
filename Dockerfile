FROM ubuntu:18.04

########################################################
# Essential packages for remote debugging and login in
########################################################
# Based on: https://github.com/shuhaoliu/docker-clion-dev
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils=1.6.14 \
    build-essential=12.4ubuntu1 \
    cmake=3.10.2-1ubuntu2.18.04.2 \
    g++=4:7.4.0-1ubuntu2.3 \
    gcc=4:7.4.0-1ubuntu2.3 \
    gcc-multilib=4:7.4.0-1ubuntu2.3 \
    gdb=8.1.1-0ubuntu1 \
    gdbserver=8.1.1-0ubuntu1 \
    openssh-server=1:7.6p1-4ubuntu0.5 \
    qemu=1:2.11+dfsg-1ubuntu7.37 \
    qemu-system-common=1:2.11+dfsg-1ubuntu7.37 \
    rsync=3.1.2-2.1ubuntu1.1 \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "export VISIBLE=now" >> /etc/profile

# 22 for ssh server. 7777 for gdb server.
EXPOSE 22 7777

# You may choose to use a different user by uncommenting the RUN lines
# User: xv6_docker
# Password: pwd
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd -ms /bin/bash xv6_docker && \
    echo 'xv6_docker:pwd' | chpasswd

########################################################
# Add custom packages and development environment here
########################################################

COPY /util/* /root/

########################################################

CMD ["/usr/sbin/sshd", "-D"]
