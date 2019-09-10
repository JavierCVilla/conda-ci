#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Setup conda
conda activate base

# Work on /root directory
cd ~

# Conda build custom recipe for cling
# Specify the local channel (-c local) to pick the local installation of clang
git clone -b root-ci https://github.com/javiercvilla/cling-feedstock
conda build -c local -c conda-forge cling-feedstock/recipe

