# GRASP-DOCKER

To reproduct some grasping baselines, I use conda environment in Docker. I use Nvidia RTX 4080. 

- Ubuntu 18.04
- Python 3.6
- Tensorflow 1.15 (for Dex-Net)
- PyTorch 1.10.0
- CUDA 11.3
- cudnn 8.2.0

## Installation

1. Clone this repository

2. Build docker image

```
docker build -t grasp-image .
```

3. Create docker container using `create_container.sh` script

Here, I mount my local workspace (e.g., `/home/xinyi/code` where conatains the method repositories) in docker container (e.g., `/workspace`) using the following commands in this script: 

```
-v /home/xinyi/code:/workspace \
```
The working directory would be synchronized. Replace the directory names to yours and execute this script. 
```
sh create_container.sh
```

4. Start the container with some name like `grasp`

```
docker start grasp
docker exec -it grasp /bin/bash
```

5. Install the requirements for different grasping baselines as follows. 

First, install some python packages 

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
Reinstall gqcnn using `pip uninstall gqcnn` and `pip install .` will solve some problems. 

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

