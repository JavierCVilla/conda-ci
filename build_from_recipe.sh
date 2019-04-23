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

conda install --yes --quiet conda-build make git
git clone http://github.com/bluehood/root-feedstock
conda build -c conda-forge root-feedstock/recipe
