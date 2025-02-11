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
 ripgrep
ADD wsl/etc /etc
