#!/usr/bin/env bash
CONTAINER_NAME=test-container
LOCAL_WORKDIR=/home/${USER}/code
CONTAINER_PATH=/code
docker run --privileged --runtime=nvidia --network host -it --name ${CONTAINER_NAME} \
    -e DISPLAY=$DISPLAY \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v ${LOCAL_WORKDIR}:${CONTAINER_PATH} \
    --workdir=${CONTAINER_WORKDIR} \
    grasp-baseline-image /bin/bash
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' ${CONTAINER_NAME}`
docker start ${CONTAINER_NAME}
docker exec -it ${CONTAINER_NAME} /bin/bash
