#!/bin/bash

# Install dependencies
sudo apt-get install \
  git \
  cmake \
  build-essential \
  libboost-program-options-dev \
  libboost-filesystem-dev \
  libboost-graph-dev \
  libboost-regex-dev \
  libboost-system-dev \
  libboost-test-dev \
  libeigen3-dev \
  libsuitesparse-dev \
  libfreeimage-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  libglew-dev \
  qtbase5-dev \
  libqt5opengl5-dev \
  libcgal-dev \
  libatlas-base-dev \
  libsuitesparse-dev

# Install Ceres Solver
cd ~/ws/git
git clone git@github.com:ceres-solver/ceres-solver.git
cd ceres-solver
git checkout $(git describe --tags)
mkdir build
cd build
cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
make -j$(nproc)
sudo make install

# Install gcc-6 compiler
sudo echo "deb http://dk.archive.ubuntu.com/ubuntu/ bionic main universe" >> /etc/apt/sources.list
cat /etc/apt/sources.list
sudo apt update
sudo apt install g++-6
sudo sed '$d' /etc/apt/sources.list
cat /etc/apt/sources.list

# Install COLMAP
cd ~/ws/git
git clone git@github.com:netdrones/colmap.git
cd colmap
git checkout dev
mkdir build
cd build
CC=/usr/bin/gcc-6 CXX=/usr/bin/g++-6 cmake ..
make -j$(nproc)
sudo make install
