#!/bin/bash
apt-get update 
conda install -c conda-forge cvxopt -y
conda install -c sirokujira python-pcl --channel conda-forge -y
pip install -r requirements.txt
cd /usr/lib/x86_64-linux-gnu/
ln -s libboost_system.so.1.65.1 libboost_system.so.1.54.0
ln -s libboost_filesystem.so.1.65.1 libboost_filesystem.so.1.54.0
ln -s libboost_thread.so.1.65.1 libboost_thread.so.1.54.0
ln -s libboost_iostreams.so.1.65.1 libboost_iostreams.so.1.54.0
