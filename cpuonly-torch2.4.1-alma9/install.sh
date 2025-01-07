#!/bin/bash
source /opt/conda/bin/activate
conda update -n base -c defaults conda
# set environment
conda config --set channel_priority strict
conda create -n pyg -c conda-forge python=3.11 root=6.30.04 -y
conda activate pyg

# install torch & torch_geometric
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install torch_geometric
pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.4.0+cpu.html
pip install cmake numpy pandas matplotlib scipy scikit-learn seaborn captum networkx
