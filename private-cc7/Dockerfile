FROM centos:7

RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo

# Install necessary packages
RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    yum groupinstall "Development Tools" -y && \
    yum install sudo util-linux zlib wget pigz parallel vim zsh cmake python3 -y && \
    yum install epel-release -y && \
    yum install voms-clients xrootd xrootd-client xrootd-server fetch-crl -y && \
    yum install glibc-common glibc-locale-source glibc-langpack-en -y && \
    yum clean all
RUN yum install myproxy -y
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN groupadd sudo && \
    useradd -m -s /bin/zsh choij && \
    usermod -aG sudo choij

# Switch to cmsusr
USER choij
WORKDIR /home/choij

# VIM setup
RUN mkdir -p ~/.vim/colors && \
    cd ~/.vim/colors && \
    curl -O https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
RUN cd ~
ADD vimrc /home/choij/.vimrc

# ZSH setup
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    cd /home/choij/.oh-my-zsh/custom/plugins && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    git clone https://github.com/djui/alias-tips.git
ADD zshrc /home/choij/.zshrc

# VOMS setup
ADD vomses /home/choij/.voms/vomses

SHELL ["/bin/zsh", "-c"]
CMD ["zsh"]
