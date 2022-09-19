#!/bin/bash
source /opt/conda/bin/activate
conda update -n base -c defaults conda
# set environment
conda config --set channel_priority strict
conda create -n torch -c conda-forge python=3.9 root -y
conda activate torch

# install torch & torch_geometric
pip install torch --extra-index-url https://download.pytorch.org/whl/cu113
pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric -f https://data.pyg.org/whl/torch-1.12.1+cu113.html

# install other packages
conda install numpy pandas matplotlib scikit-learn -c conda-forge -y
