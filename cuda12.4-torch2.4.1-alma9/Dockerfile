FROM almalinux/9-base:9.4
LABEL maintainer="Jin Choi <choij@cern.ch>"

# Install necessary packages
RUN echo "fastestmirror=1" >> /etc/dnf/dnf.conf
RUN dnf update -y && \
    dnf groupinstall "Development Tools" -y && \
    dnf install epel-release -y && \
    dnf install util-linux-user zlib wget pigz parallel cmake vim zsh -y && \
    dnf install glibc-common glibc-locale-source glibc-langpack-en -y && \
    dnf install xrootd xrootd-client xrootd-server myproxy -y && \
    dnf clean all -y
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh
ENV PATH="/opt/conda/bin:${PATH}"

ADD install.sh /root/install.sh
RUN chmod +x /root/install.sh && /root/install.sh && rm /root/install.sh

# Entrypoint
RUN echo "source /opt/conda/bin/activate pyg" >> /etc/profile.d/conda.sh
