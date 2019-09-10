#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# ROOT gtests require lsb_release
yum install -y redhat-lsb-core

# Enable conda
. /opt/conda/etc/profile.d/conda.sh
conda activate base

# Install base requirements
conda install --yes --quiet conda-build make git
