FROM osrf/ros:noetic-desktop-full

WORKDIR /home
ENV HOME /home

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# install vim
RUN apt-get update -qq
RUN apt-get install -y tzdata
RUN apt-get update && apt-get install -y git lsb-release sudo gnupg curl


# add user
RUN useradd -m ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo
USER ubuntu

RUN apt-get install -y ros-noetic-rqt-* 
RUN apt-get install -y python3-catkin-tools

# set catkin workspace
RUN source /opt/ros/noetic/setup.bash && mkdir -p catkin_ws/src && cd ~/catkin_ws && catkin build 

COPY config/.bashrc /home/.bashrc

# orne_or install
