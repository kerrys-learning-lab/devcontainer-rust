# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.0/containers/ubuntu/.devcontainer/base.Dockerfile

ARG VARIANT="ubuntu-22.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# https://bobcares.com/blog/debian_frontendnoninteractive-docker/
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  bash-completion \
                        i2c-tools \
                        libi2c0 \
                        libi2c-dev \
                        pip

# https://docs.docker.com/engine/install/ubuntu/
RUN apt-get install -y  ca-certificates \
                        curl \
                        gnupg \
                        lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y  docker-ce \
                        docker-ce-cli \
                        containerd.io \
                        docker-compose-plugin

RUN usermod -a -G docker vscode

USER vscode
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y && \
    /home/vscode/.cargo/bin/cargo install --force cross
