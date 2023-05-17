FROM fedora:35
MAINTAINER Jin Choi	<choij@cern.ch>

WORKDIR /root
RUN dnf update -y
RUN dnf install util-linux-user -y
RUN dnf groupinstall "Development Tools" -y

# Install cuda packages
ADD cuda-repo-fedora35-11-8-local-11.8.0_520.61.05-1.x86_64.rpm /root/cuda-repo-fedora35-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
RUN rpm -i cuda-repo-fedora35-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
RUN dnf clean all
RUN dnf install cuda -y
RUN rm cuda-repo-fedora35-11-8-local-11.8.0_520.61.05-1.x86_64.rpm

ADD cudnn-linux-x86_64-8.8.1.3_cuda11-archive /root/cudnn-linux-x86_64-8.8.1.3_cuda11-archive
RUN cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
RUN cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
RUN chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
RUN rm -rf cudnn-*

ENV PATH=${PATH}:/usr/local/cuda/bin
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/bin/cuda/lib64

# install conda
ADD Miniconda3-latest-Linux-x86_64.sh /root/Miniconda3-latest-Linux-x86_64.sh
RUN chmod +x Miniconda3-latest-Linux-x86_64.sh && \
	/root/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda3-latest-Linux-x86_64.sh
ADD install.sh /root/install.sh
RUN chmod +x install.sh
RUN ./install.sh
RUN rm install.sh
