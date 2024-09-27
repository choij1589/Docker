FROM almalinux/9-base:9.4
LABEL maintainer="Jin Choi <choij@cern.ch>"

# Perform the installation as root
USER root
WORKDIR /root

RUN echo "fastestmirror=1" >> /etc/dnf/dnf.conf
RUN dnf update -y && \
    dnf groupinstall "Development Tools" -y && \
    dnf install bash zsh -y && \
    dnf install -y automake bzip2 bzip2-libs bzip2-devel coreutils-single cmake3 e2fsprogs \
                e2fsprogs-libs perl file file-libs fontconfig freetype gcc-c++ git \
                glibc glibc-common glibc-langpack-en glibc-locale-source krb5-libs \
                libaio libcom_err libcom_err-devel libgomp libICE \
                libSM libX11 libX11-devel libxcrypt libXcursor libXext \
                libXext-devel libXft libXft-devel libXi libXinerama \
                libXmu libXpm libXpm-devel libXrandr libXrender \
                libglvnd-opengl mesa-libGL mesa-libGLU mesa-libGLU-devel \
                java-1.8.0-openjdk-devel libtool m4 make \
                ncurses ncurses-libs ncurses-devel nspr nss nss-devel nss-util \
                openssl openssl-devel openssl-libs pcre pcre-devel \
                patch popt popt-devel python3 python3-pip readline readline-devel rpm-build \
                rsync tcl tcsh time tk wget which zlib zsh tcl-devel tk-devel krb5-devel \
                bc strace tar zip unzip hostname nano libnsl procps-ng environment-modules yum-utils && \
    dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm && \
    dnf install -y voms-clients-cpp krb5-workstation python3-psutil myproxy apptainer python3-requests sudo && \
    dnf install -y ca-certificates &&\
    dnf install -y dnf-plugins-core yum-plugin-versionlock && ([ "@EXTRA_PACKAGES@" != "" ] && dnf -y install @EXTRA_PACKAGES@ || true) &&\
    yum clean all

RUN curl https://storage-ci.web.cern.ch/storage-ci/storageci.key | gpg --import && \
    yum-config-manager --add-repo "https://storage-ci.web.cern.ch/storage-ci/eos/diopside-depend/el-9/x86_64/" && \
    yum-config-manager --add-repo "https://storage-ci.web.cern.ch/storage-ci/eos/diopside/tag/testing/el-9/x86_64/" && \
    dnf update -y && \
    dnf install --nogpgcheck -y eos-client eos-fusex && \
    yum clean all

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    localedef -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG="en_US.UTF-8"

RUN groupadd -g 1000 cmsusr && adduser -u 1000 -g 1000 -G root cmsusr && \
    echo "cmsusr ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers && \
    groupadd -g 1001 cmsinst && adduser -u 1001 -g 1001 cmsinst && \
    install -d /opt && install -d -o cmsinst /opt/cms

# Make Images grid/singularity compatible
RUN mkdir -p /cvmfs /afs /eos /pool /code && \
    chmod 1777 /afs /eos /pool /code && \
    chown -R cmsusr:cmsusr /code

ADD dotfiles/dot-pythonrc.py /etc/pythonrc.py
ADD dotfiles/dot-bashrc      /etc/profile.d/bashrc.sh

#RUN dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo -y && \
#    dnf module install nvidia-driver:latest-dkms -y && \
#    dnf install cuda-12-1 -y && \
#    dnf clean all -y

#ENV PATH=${PATH}:/usr/local/cuda-12.1/bin

# install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
ENV PATH="/opt/conda/bin:${PATH}"
ADD install.sh /root/install.sh
RUN chmod +x /root/install.sh && /root/install.sh && rm /root/install.sh && chmod -R a+rx /opt/conda/envs/pyg && chmod -R a+rx /opt/conda/syne-tune
RUN echo "source /opt/conda/bin/activate pyg" >> /etc/profile.d/conda.sh

# Add a couple of useful files to cmsusr account
USER cmsusr
ENV USER cmsuser
ENV HOME /home/cmsusr
RUN sudo chown -R cmsusr /home/cmsusr && chmod 755 /home/cmsusr



