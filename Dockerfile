FROM nvidia/cuda:8.0-cudnn7-devel-ubuntu16.04

LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENCV_DNN_OPENCL_ALLOW_ALL_DEVICES=1

# get deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-dev python3-pip \
    git g++ wget make cmake \
    libopencv-dev \
    python3-setuptools \
    software-properties-common

# install nvidia drivers for the aci gpus
RUN add-apt-repository -y ppa:graphics-drivers/ppa
RUN apt-get install -y nvidia-390-dev

RUN pip3 install opencv-contrib-python
RUN pip3 install wheel
RUN pip3 install --upgrade imutils

RUN cd /opt && \
    git clone https://github.com/pjreddie/darknet && \
    cd darknet && \
    make

RUN cd /opt/darknet && \
    wget https://pjreddie.com/media/files/yolov3.weights

# Add opencv from source?
# RUN cd /opt && \
#     git clone https://github.com/opencv/opencv.git
# RUN cd /opt && \
#     git clone https://github.com/opencv/opencv_contrib.git
#
# RUN cd /opt/opencv && \
#     mkdir -p build && \
#     cd build && \
#     cmake -D CMAKE_BUILD_TYPE=RELEASE \
#           -D CMAKE_INSTALL_PREFIX=/usr/local \
#           -D INSTALL_C_EXAMPLES=OFF \
#           -D INSTALL_PYTHON_EXAMPLES=OFF \
#           -D WITH_TBB=ON \
#           -D WITH_V4L=ON \
#         -D WITH_QT=ON \
#         -D WITH_OPENGL=ON \
#         -D WITH_CUDA=ON \
#         -D ENABLE_FAST_MATH=1 \
#         -D CUDA_FAST_MATH=1 \
#         -D WITH_CUBLAS=1 \
#         -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
#         -D BUILD_EXAMPLES=OFF .. && \
#     make -j4 && \
#     make install

# Python script assembled from
# https://www.pyimagesearch.com/2018/11/12/yolo-object-detection-with-opencv/

RUN mkdir /opt/yolo && \
  cd /opt/yolo && \
  mkdir yolo-coco

ADD ./assets/yolo-coco /opt/yolo/yolo-coco
ADD ./assets/yolo.py /opt/yolo
ADD ./assets/yolo_video.py /opt/yolo
ADD ./assets/vid.mp4 /opt/yolo

RUN cd /opt/yolo/yolo-coco && \
    cp /opt/darknet/yolov3.weights yolov3.weights

ENTRYPOINT ["/bin/bash"]
