#!/bin/bash
set -x

# Docker info
export IMAGE="condaforge/linux-anvil-comp7"
export CONTAINER=root-conda-test-$(date +%s)

# Create docker container
docker run --name ${CONTAINER} -t --detach $IMAGE

# Copy build script into the "/root/" directory inside the container
docker cp ${WORKSPACE}/conda-ci/build_from_recipe.sh "${CONTAINER}:/root/."

# Run build script 
# * install conda-build, make and git
# * clone our fork of the conda recipe to build root (+gtests)
# * build root with conda
docker exec "${CONTAINER}" /bin/bash /root/build_from_recipe.sh

# Get the most recent conda working directory
# There should be one single directory
build_dir=`docker exec -i "${CONTAINER}" find /opt/conda/conda-bld -maxdepth 1 -type d -iname "root_*"`

docker stop "${CONTAINER}"

# Extract CTest logs
docker cp "${CONTAINER}:$build_dir/work/build-dir/Testing/" ${WORKSPACE}/ctest_output
docker rm "${CONTAINER}"
ls -R
