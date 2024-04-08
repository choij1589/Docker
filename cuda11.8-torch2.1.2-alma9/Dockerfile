FROM almalinux/9-base:9.3
MAINTAINER Jin Choi <choij@cern.ch>

WORKDIR /root
RUN dnf update -y
RUN dnf groupinstall "Development Tools" -y
RUN dnf install util-linux-user zlib wget -y

# Install cuda packages
RUN dnf install epel-release -y
RUN dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo -y
RUN dnf module install nvidia-driver:latest-dkms -y

# install conda
ADD Miniconda3-latest-Linux-x86_64.sh /root/Miniconda3-latest-Linux-x86_64.sh
RUN chmod +x Miniconda3-latest-Linux-x86_64.sh && \
        /root/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
        rm Miniconda3-latest-Linux-x86_64.sh
ADD install.sh /root/install.sh
RUN chmod +x install.sh && /root/install.sh && rm install.sh

# Entrypoint
RUN echo "source /opt/conda/bin/activate && conda activate pyg" >> ~/.bashrc
