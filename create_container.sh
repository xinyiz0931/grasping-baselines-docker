# docker run -it --runtime=nvidia --network host -d --name grasp3 \
#                -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix -e LIBGL_ALWAYS_INDIRECT=0 -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics --gpus all \
#                -v /home/xinyi/code:/workspace \
#                grasp-cuda /bin/bash
# docker run -i -d --name grasp \
#                 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix -e LIBGL_ALWAYS_INDIRECT=0 -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics --gpus all \
#                 -v /home/xinyi/code:/workspace \
#                 grasp-image bash

docker run --runtime=nvidia --network host -it --name grasp \
	-e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix \
    -v /home/xinyi/code:/workspace \
	grasp-cuda bash

