#!/bin/bash
source /opt/conda/bin/activate
conda update -n base -c defaults conda
# set environment
conda config --set channel_priority strict
conda create -n pyg -c conda-forge python=3.11 root=6.30.04 -y
conda activate pyg

# install torch & torch_geometric
pip install torch==2.3.1 --index-url https://download.pytorch.org/whl/cu121 
pip install torch_geometric
pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.3.0+cu121.html
pip install numpy pandas matplotlib scipy scikit-learn seaborn captum networkx

# install synce_tune
cd /opt/conda
git clone https://github.com/awslabs/syne-tune.git && cd syne-tune && pip install -e '.[extra]' && cd -
