FROM ubuntu:14.04

# INSTALL GIT
RUN apt-get update -qq
RUN apt-get install git -yqq

# INSTALL DOCKER CE
RUN apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
RUN curl -sSL https://get.docker.com/ | sh
VOLUME /var/lib/docker

# INSTALL PYTHON 2.7 AND PIP
RUN apt install python2.7 python-pip -qqy

# INSTALL AWSCLI
RUN pip install awscli --user
ENV PATH ~/.local/bin:$PATH

# INSTALL NVM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.0
RUN mkdir $NVM_DIR
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN . $NVM_DIR/nvm.sh \
    nvm install $NODE_VERSION \
    nvm alias default $NODE_VERSION \
    nvm use default
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# INSTALL YARN
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.6.0

# INSTALL GERENCIO UPGRADE
RUN npm i -g gerencio-upgrade@^3.1.1
