#!/bin/bash

eval "docker container run --network host --rm -it --name orne_or -e DISPLAY=$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $PWD/../catkin_ws/:/home/docker/catkin_ws --privileged only-noetic"
