FROM ubuntu:16.04

LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

# get deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-dev python3-pip \
    git g++ wget make cmake


RUN cd /opt && \
    git clone https://github.com/pjreddie/darknet && \
    cd darknet && \
    make

RUN cd /opt/darknet && \
    wget https://pjreddie.com/media/files/yolov3.weights
