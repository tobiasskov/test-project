FROM ubuntu:24.04 AS dev

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    gdb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

##### Create a non-root user for security:
# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user
# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user



USER ubuntu

#####
FROM ubuntu:24.04 AS prod

ARG USERNAME=nonrootuser
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME 

USER $USERNAME

