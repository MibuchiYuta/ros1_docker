FROM osrf/ros:noetic-desktop-full

ENV USER docker
ENV PASSWORD docker
ENV HOME /home/${USER}
WORKDIR ${HOME}

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# install
RUN apt-get update -qq
RUN apt-get install -y tzdata
RUN apt-get update && apt-get install -y \
    git \
    lsb-release \
    sudo \
    gnupg \
    curl
RUN apt-get install -y \
    ros-noetic-rqt-* \
    ros-noetic-moveit \
    ros-noetic-roboticsgroup-upatras-gazebo-plugins \
    ros-noetic-position-controllers \
    ros-noetic-ros-control \
    ros-noetic-ros-controllers　\

RUN apt-get install -y python3-catkin-tools

RUN curl -o .git-completion.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
RUN curl -o .git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
COPY config/.bashrc ${HOME}/.bashrc

# add user
RUN useradd --user-group --create-home --shell /bin/false ${USER}
RUN gpasswd -a ${USER} sudo
RUN echo "${USER}:${PASSWORD}" | chpasswd
RUN sed -i.bak "s#${HOME}:#${HOME}:${SHELL}#" /etc/passwd
RUN gpasswd -a ${USER} dialout
RUN chown -R ${USER}:${USER} ${HOME}

# set defalut user
USER ${USER}
RUN cd ${HOME}

