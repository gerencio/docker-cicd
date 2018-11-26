FROM python:2.7.15-jessie

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
RUN npm i -g gerencio-upgrade@^3.0.1
