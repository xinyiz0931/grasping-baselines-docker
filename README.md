# GRASP-BASELINE-DOCKER

To reproduct some grasping baselines, I use conda environment in Docker. I use Nvidia RTX 4080. 

- Ubuntu 18.04
- Python 3.6
- Tensorflow 1.15 (for Dex-Net)
- PyTorch 1.10.0
- CUDA 11.3
- cudnn 8.2.0
- ROS melodic

This docker evironment can be used for the following grasping methods. 

- Conda env: `py36`
  - Dex-Net
  - PointNetGPD

- Conda env: `py38`
  - DexGraspNet
  - UniDexGrasp

- Both envs: 
  - GraspNet
  - GraspIt!

## Installation

1. Clone this repository

2. Build docker image

I set the `make -j5`. Before building the image, you can speed up the compile process by revising line 23 and 29.  
```
docker build -t grasp-image .
```

3. Create and execute docker container using `launch.sh` script

Here, I mount my local workspace (e.g., `/home/xinyi/code` where conatains the method repositories) in docker container (e.g., `/workspace`) using the following commands in this script: 

```
-v /home/xinyi/code:/workspace \
```
The working directory would be synchronized. Replace the directory names to yours and execute this script. 
```
sh launch.sh
```

4. Install the requirements for different grasping baselines as follows. 

First, install some packages

Install nvidia-opengl driver based on your nvidia driver version. 
```
nvidia_gl_ver=$(echo $(nvidia-smi --query-gpu=driver_version --format=csv,noheader) | cut -d '.' -f 1)
apt-get install "libnvidia-gl-${nvidia_gl_ver}" -y
```

```
sh install-requisites.sh
```


### Install Dex-Net 2.0

Install tensorflow 1.15, use the following commands if you're using CUDA 11.x. Or you can use `install-dexnet.sh` script. 

The following commands are added to the shell script file to install tensorflow 1.x coupled with CUDA 11.x. 

```
pip install nvidia-pyindex
pip install nvidia-tensorflow[horovod]
pip install nvidia-tensorboard==1.15
```

```
cd gqcnn
python setup.py develop
```

Download the dataset. 

Test the code

```
sh ./scripts/policies/run_all_dex-net_2.0_examples.sh 
```

```
sh scripts/training/train_dex-net_2.0.sh
```

Sometimes there would be bugs about input/output shape. Training script tends to revised the network architecture somewhere. Need to be revised the source code. However, if you only use it for the inference without finetuning, it would be alright. 

### Install PointNetGPD

Directly use `install-pointnetgpd.sh` script. 

```
sh install-pointnetgpd.sh
```

Install dependencies `meshpy`, `dex-net`.

```
cd $PointNetGPD_PATH/meshpy
python setup.py develop
cd $PointNetGPD_PATH/dex-net
python setup.py develop
```

Download the dataset using


Test using the following command. 

```
cd $PointNetGPD_PATH/dex-net/apps
python read_grasp_from_file.py
```

### Install GraspNet-baseline

Just follow the official instuctions here https://github.com/graspnet/graspnet-baseline. 

The authors provide pytorch 1.6. But I use RTX 4080 with CUDA 11.3, I cannot use this version of PyTorch. 

I install 1.10.0+cu113 instead. Check [here](https://pytorch.org/get-started/previous-versions/) to find the suitable pytorch and cuda. 
(Note that I installed 1.10.1 and there're some bugs, so that I downgrade to 1.10.0 then it's great, other version has not been tested)

### Install GraspIt

Follow this [instruction](https://graspit-simulator.github.io/). 
