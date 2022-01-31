#
# nodejs/build/Dockerfile
#
#   Create a NodeJS Docker container image.
#
#   docker build -f Dockerfile  \
#       --build-arg NODEJS_VERSION="14.x" \
#       -t home/nodejs:14.x .
#

ARG	UBUNTU_VERSION="focal"
ARG	NODEJS_VERSION="14.x"

FROM ubuntu:${UBUNTU_VERSION}
LABEL MAINTAINER raymondstrose@hotmail.com

ARG	NODEJS_VERSION

RUN apt-get update && apt-get upgrade -y
COPY preseed.txt preseed.txt
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true; debconf-set-selections preseed.txt; apt-get install -y bash ccache npm curl unzip zip

RUN uname -a

RUN apt-get purge -y --auto-remove nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_$NODEJS_VERSION | bash -
RUN apt-get install -y nodejs

