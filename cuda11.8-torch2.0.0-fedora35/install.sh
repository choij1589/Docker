#!/bin/bash
source /opt/conda/bin/activate
conda update -n base -c defaults conda
# set environment
conda config --set channel_priority strict
conda create -n torch -c conda-forge python=3.11 root -y
conda activate torch

# install torch & torch_geometric
pip install torch --index-url https://download.pytorch.org/whl/cu118
pip install torch_geometric
pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.0.0+cu118.html
pip install python-telegram-bot

# install other packages
pip install numpy pandas matplotlib scikit-learn
