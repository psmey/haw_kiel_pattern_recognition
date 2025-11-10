FROM ubuntu:noble

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8

# Install packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    git \
    wget \
    octave octave-doc octave-dev \
    # Octave dependecies
    fonts-freefont-otf ghostscript \
    # Enable Octave rendering headless by mocking a virtual screen
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install Hadolint
# https://github.com/hadolint/hadolint
ENV HADOLINT_VERSION=v2.12.0
RUN wget -q https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64 \
    && wget -q https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64.sha256 \
    # Verify file
    && sha256sum -c /hadolint-Linux-x86_64.sha256 \
    && rm /hadolint-Linux-x86_64.sha256 \
    # Make executable
    && chmod +x /hadolint-Linux-x86_64 \
    # Add to PATH
    && mv /hadolint-Linux-x86_64 /usr/local/bin/hadolint \
    # Verify installation
    && hadolint --version
