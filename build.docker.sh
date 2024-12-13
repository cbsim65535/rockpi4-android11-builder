#!/bin/bash
sudo docker build -t rockpi4-android11-builder --build-arg USER_ID=`id -u` --build-arg GROUP_ID=`id -g` .
