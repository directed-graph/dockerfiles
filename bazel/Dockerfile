
FROM gcc:10.2.0
ARG BAZEL_VERSION=4.0.0

RUN apt-get update && apt-get install -y wget unzip zip && apt-get clean

RUN wget -nv -O bazel-installer.sh \
  https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
  chmod +x ./bazel-installer.sh && \
  ./bazel-installer.sh && \
  rm ./bazel-installer.sh

