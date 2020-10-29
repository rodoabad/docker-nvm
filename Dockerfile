FROM debian:latest

LABEL maintainer="Rodo Abad <@rodoabad>"
LABEL name="docker-nvm"
LABEL version="latest"

# Use bash.
SHELL ["bin/bash", "-l","-c"]

# Update Debian.
RUN apt-get update

# Install necessary packages for NVM.
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

# Confirm NVM installation.
RUN nvm --version

# Setup development workspace.
RUN mkdir /workspace
WORKDIR /workspace

# Go to workspace.
RUN cd /workspace

# Install required Node version based off the project's `.nvmrc` file.
RUN nvm install

# Confirm Node and NPM installation.
RUN node --version
RUN npm --version

ENV PATH /workspace/node_modules/.bin:$PATH
