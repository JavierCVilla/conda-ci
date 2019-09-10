#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Setup conda
conda activate base

# Work on /root directory
cd ~

# Conda-build custom recipe for clang
git clone -b root-ci https://github.com/JavierCVilla/clangdev-feedstock.git
conda build -c conda-forge clangdev-feedstock/recipe --variants "{'clang_variant': ['master']}"
