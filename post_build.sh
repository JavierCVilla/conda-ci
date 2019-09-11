#!/bin/bash

# Get the most recent conda working directory
# There should be one single directory
build_dir=`docker exec -i "${CONTAINER}" find /opt/conda/conda-bld -maxdepth 1 -type d -iname "root_*"`

docker stop "${CONTAINER}"

# Extract CTest logs
docker cp "${CONTAINER}:$build_dir/work/build-dir/Testing/" ${WORKSPACE}/ctest_output
docker rm "${CONTAINER}"
ls -R

# Clean environment
unset CONTAINER
unset IMAGE
