#!/bin/bash
source /opt/conda/bin/activate
conda update -n base -c defaults conda
# set environment
conda config --set channel_priority strict
conda create -n torch -c conda-forge python=3.10 root=6.24.06 -y
conda activate torch

# install torch & torch_geometric
pip install torch --extra-index-url https://download.pytorch.org/whl/cu117
pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric -f https://data.pyg.org/whl/torch-1.13.0+cu117.html

# install other packages
conda install numpy pandas matplotlib scikit-learn -c conda-forge -y
