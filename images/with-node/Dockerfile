ARG BASEOS=oh-my-devops
FROM $BASEOS

WORKDIR /src

ADD install-nvm.sh .
RUN ./install-nvm.sh

ADD install-nvm-verify.sh .
RUN ./install-nvm-verify.sh
RUN echo "source $HOME/.bashrc" >> $HOME/.zshrc

WORKDIR /git

#TODO: Add Docker installation
