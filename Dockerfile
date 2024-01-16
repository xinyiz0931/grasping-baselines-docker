FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu18.04
LABEL maintainer="Xinyi Zhang <xinyiz0931@gmail.com>"

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	vim wget \
	cmake build-essential git \
	libeigen3-dev \
	libboost-all-dev \
	libgl1-mesa-dev	\
	libxt-dev \
	libflann1.9 libflann-dev \
	qtbase5-dev \
	libxrender1 \
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
    conda create -n ws python=3.6 && \
    conda init && \
    echo "conda activate ws" >> ~/.bashrc

ENV CONDA_DEFAULT_ENV ws && \
    PATH /opt/conda/envs/ws/bin:$PATH

WORKDIR /
