#!/bin/bash

# Remove CUDA artifacts
sudo rm /etc/apt/sources.list.d/cuda*
sudo apt remove --autoremove nvidia-cuda-toolkit --assume-yes
sudo apt remove --autoremove nvidia-* --assume-yes
sudo apt purge libcudnn* --assume-yes
sudo apt-get purge nvidia* --assume-yes
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /usr/local/cuda*

# Install CUDA 10.1

sudo apt update
sudo add-apt-repository ppa:graphics-drivers --assume-yes
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda_learn.list'

sudo apt update
sudo apt install cuda-10-1 --assume-yes

# Install cuDNN
gsutil -m cp gs://netdron.es/libcudnn7/* .
sudo dpkg -i libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
sudo dpkg -i libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
rm *.deb

# Reboot
sudo reboot now
