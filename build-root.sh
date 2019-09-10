#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Setup conda
. /opt/conda/etc/profile.d/conda.sh
conda activate base

# Work on /root directory
cd ~

# Conda build root master
export ROOT_JENKINS_GIT_REV=master
git clone http://github.com/javiercvilla/root-feedstock
conda build -c local -c conda-forge root-feedstock/recipe
