FROM ubuntu:16.04

LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

# get deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-dev python3-pip \
    git g++ wget make cmake \
    libopencv-dev python3-setuptools

RUN pip3 install opencv-python
RUN pip3 install imutils

RUN cd /opt && \
    git clone https://github.com/pjreddie/darknet && \
    cd darknet && \
    make

RUN cd /opt/darknet && \
    wget https://pjreddie.com/media/files/yolov3.weights

# Python script assembled from
# https://www.pyimagesearch.com/2018/11/12/yolo-object-detection-with-opencv/

RUN mkdir /opt/yolo && \
  cd /opt/yolo && \
  mkdir yolo-coco

ADD ./assets/yolo-coco /opt/yolo/yolo-coco
ADD ./assets/yolo.py /opt/yolo
ADD ./assets/yolo_video.py /opt/yolo
RUN cd /opt/yolo/yolo-coco && \
    wget https://pjreddie.com/media/files/yolov3.weights

# WORKDIR ["/opt/yolo"]
ENTRYPOINT ["/bin/bash"]
