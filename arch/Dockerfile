ARG BASEOS=archlinux
FROM $BASEOS
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm \
 vi \
 less \ 
 git \
 azure-cli \
 zsh \
 terraform \
 myrepos \
 neovim \
 stow \
 man-db \
 man-pages \
 gcc \
 unzip \
 wget \
 ripgrep \
 make \
 sudo \
 tree \
 diffutils \
 patch \
 fd \
 python-pip \
 luarocks \
 kubectl \
 kustomize
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen
ADD wsl/etc /etc
