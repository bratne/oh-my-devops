ARG BASEOS=oh-my-devops
FROM $BASEOS

ADD install-nvm.sh .
RUN ./install-nvm.sh

ADD install-nvm-verify.sh .
RUN ./install-nvm-verify.sh

#TODO: Add Docker installation
