FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu18.04
LABEL maintainer="Xinyi Zhang <xinyiz0931@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ "Asia/Tokyo"

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    software-properties-common \
    git sudo curl g++ make git vim \
    snapd zip unzip wget cmake \
	libboost-all-dev \
	libeigen3-dev \
	libflann1.9 libflann-dev \
    libssl-dev \
    freeglut3-dev \
    build-essential \
    software-properties-common \
    lsb-core \
    ffmpeg \
    apt-utils \
    ninja-build \
    libatlas-base-dev \
    libblas-dev \
    liblapack-dev \
    usbutils \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
	libgl1-mesa-dev	\
	libxt-dev \
	libflann1.9 libflann-dev \
	qtbase5-dev \
	libxrender1 \
	lsb-release \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget https://www.vtk.org/files/release/8.1/VTK-8.1.0.tar.gz && \
	tar -zxf VTK-8.1.0.tar.gz && \
	cd VTK-8.1.0 && mkdir build && cd build && \
	cmake .. && \
	make -j20 && make install && \
	make clean && cd /opt && rm -rf VTK-8.1.0* 

RUN git clone -b pcl-1.9.1 https://github.com/PointCloudLibrary/pcl.git && \
	cd pcl && mkdir build && cd build && \
	cmake .. && \
	make -j20 && make install && \
	make clean && cd /opt && rm -rf pcl 

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 && \
    rm -r Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/miniconda3/bin:$PATH

RUN pip install --upgrade pip && \
    conda update -n base -c defaults conda && \
    conda create -n py36 python=3.6 && \
    conda create -n py38 python=3.8 && \
    conda init && \
    echo "conda activate py38" >> ~/.bashrc

ENV CONDA_DEFAULT_ENV py38 && \
    PATH /opt/conda/envs/py36/bin:$PATH \
    PATH /opt/conda/envs/py38/bin:$PATH

# install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt-get update && \
    apt-get install -y ros-melodic-desktop-full
RUN apt-get install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

RUN sudo rosdep init
RUN rosdep update
ENV LC_ALL "C"

WORKDIR /
