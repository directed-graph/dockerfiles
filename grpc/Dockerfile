
FROM implementing/bazel
ARG GRPC_VERSION=v1.34.0

RUN apt-get update && \
    apt-get install -y build-essential autoconf libtool pkg-config cmake && \
    apt-get clean

ENV CC gcc
ENV CXX g++

RUN git clone -b ${GRPC_VERSION} https://github.com/grpc/grpc /var/local/git/grpc && \
    cd /var/local/git/grpc && \
    bazel build :all

