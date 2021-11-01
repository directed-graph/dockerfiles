FROM archlinux:base-devel

# Run pacman first before anything else to take advantage of build cache.
ARG PACKAGES="git bazel python rsync"
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed ${PACKAGES} && \
    pacman -Sc --noconfirm

ARG BUILD_DIR="/mnt/build"
ARG BUILD_USER="builder"
ARG BUILD_USER_GID="1000"
ARG BUILD_USER_UID="1000"
ARG PROJECT_DIR="/mnt/project"

COPY builder.bash /usr/local/bin/builder.bash
RUN chmod go+rx /usr/local/bin/builder.bash

VOLUME ["${BUILD_DIR}", "${PROJECT_DIR}"]

ENV BUILD_DIR="${BUILD_DIR}"
ENV BUILD_USER="${BUILD_USER}"
ENV BUILD_USER_GID="${BUILD_USER_GID}"
ENV BUILD_USER_UID="${BUILD_USER_UID}"
ENV PROJECT_DIR="${PROJECT_DIR}"
ENV USE_BUILD_DIR="no"

ENTRYPOINT ["/usr/local/bin/builder.bash"]
