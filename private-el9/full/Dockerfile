FROM choij1589/private-el9:base

# Install necessary packages
RUN dnf update -y && \
    dnf groupinstall "Development Tools" -y && \
    dnf install epel-release -y && \
    dnf install sudo util-linux-user zlib wget pigz parallel vim zsh cmake -y
RUN dnf install glibc-common glibc-locale-source glibc-langpack-en -y
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN groupadd sudo && \
    useradd -m -s /bin/zsh cmsusr && \
    usermod -aG sudo cmsusr

# Switch to cmsusr
USER cmsusr
WORKDIR /home/cmsusr

# VIM setup
RUN mkdir -p ~/.vim/colors && \
    cd ~/.vim/colors && \
    curl -O https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
RUN cd ~
ADD vimrc /home/cmsusr/.vimrc

# ZSH setup
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    cd /home/cmsusr/.oh-my-zsh/custom/plugins && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git && \ 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    git clone https://github.com/djui/alias-tips.git
ADD zshrc /home/cmsusr/.zshrc

SHELL ["/bin/zsh", "-c"]
CMD ["zsh"]
