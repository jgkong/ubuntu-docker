FROM ubuntu:18.04
MAINTAINER jgkong@kr.ibm.com

# Set environment variables.
ENV DEBIAN_FRONTEND=noninteractive

# Install.
RUN apt-get update -qq && \
  apt-get upgrade -qq && \
  # Install Docker
  apt-get install -qq apt-transport-https ca-certificates curl gnupg-agent software-properties-common \
    bash-completion && \
  # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
  apt-get update -qq && \
  apt-get install -qq docker-ce docker-ce-cli containerd.io && \
  apt-get autoremove -qq && \
  apt-get clean autoclean && \
  rm -rf /tmp/* /var/tmp/* /var/log/*.log /var/log/apt/*.log && \
  # delete all the apt list files since they're big and get stale quickly
  rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
