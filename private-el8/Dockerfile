FROM cern/alma8-base

# Install necessary packages
RUN dnf update -y && \
    dnf groupinstall "Development Tools" -y && \
    dnf install epel-release -y && \
    dnf install sudo util-linux-user zlib wget pigz parallel vim zsh cmake -y && \
    dnf install voms-clients xrootd xrootd-client xrootd-server fetch-crl -y
RUN dnf install glibc-common glibc-locale-source glibc-langpack-en myproxy -y
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN groupadd sudo && \
    useradd -m -s /bin/zsh choij && \
    usermod -aG sudo choij

# Switch to choij
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
