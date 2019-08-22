#!/bin/bash

# This script setups the environment to use conda and 
# conda-builds root using a custom recipe (with gtests)
#
# This script is meant to be run on a docker container
#

set -euo pipefail
IFS=$'\n\t'

# ROOT gtests require lsb_release
yum install -y redhat-lsb-core

# Enable conda
. /opt/conda/etc/profile.d/conda.sh
conda activate base

# Install base requirements
conda install --yes --quiet conda-build make git

# Work on /root directory
cd ~

# Conda-build custom recipe for clang
git clone -b root-ci https://github.com/JavierCVilla/clangdev-feedstock.git
conda build -c conda-forge clangdev-feedstock --variants "{'clang_variant': ['master']}"

# Conda build custom recipe for cling
# Specify the local channel (-c local) to pick the local installation of clang
git clone -b root-ci https://github.com/javiercvilla/cling-feedstock
conda build -c local -c conda-forge cling-feedstock

# Conda build root master
export ROOT_JENKINS_GIT_REV=master
git clone http://github.com/javiercvilla/root-feedstock
conda build -c conda-forge root-feedstock/recipe
