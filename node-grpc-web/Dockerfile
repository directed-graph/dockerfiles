
ARG NODE_VERSION=12-stretch-slim

FROM node:${NODE_VERSION}

ARG GRPC_WEB_VERSION=1.2.1
ARG PROTOBUF_VERSION=3.14.0

RUN apt-get -qq update && apt-get -qq install -y curl unzip

WORKDIR /tmp

RUN curl -sSL https://github.com/protocolbuffers/protobuf/releases/download/\
v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip \
  -o protoc.zip && \
  unzip -qq protoc.zip && \
  cp ./bin/protoc /usr/local/bin/protoc && \
  cp -r ./include/* /usr/local/include

RUN curl -sSL https://github.com/grpc/grpc-web/releases/download/\
${GRPC_WEB_VERSION}/protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 \
  -o /usr/local/bin/protoc-gen-grpc-web && \
  chmod +x /usr/local/bin/protoc-gen-grpc-web

