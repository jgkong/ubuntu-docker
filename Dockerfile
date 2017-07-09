FROM ubuntu:14.04
MAINTAINER jgkong@kr.ibm.com

# Set environment variables.
ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    locale-gen en_US.UTF-8 && \
    echo LANG=\"en_US.UTF-8\" > /etc/default/locale

# Install.
RUN apt-get update -qq && \
  apt-get upgrade -qq && \
  # Install Docker
  apt-get install -qq apt-transport-https ca-certificates curl software-properties-common \
    bash-completion && \
  # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu trusty stable" && \
  apt-get update -qq && \
  apt-get install -qq docker-ce && \
  apt-get autoremove -qq && \
  apt-get clean autoclean && \
  rm -rf /tmp/* /var/tmp/* /var/log/*.log /var/log/apt/*.log && \
  # delete all the apt list files since they're big and get stale quickly
  rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
