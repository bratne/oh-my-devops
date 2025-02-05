ARG BASEOS=debian
FROM $BASEOS
RUN apt-get update
RUN apt-get install -y sudo --no-install-recommends

WORKDIR /src

## Terraform installation
ADD install-terraform-prereqs.sh .
RUN ./install-terraform-prereqs.sh
ADD install-terraform.sh .
RUN ./install-terraform.sh
ADD install-terraform-verify.sh .
RUN ./install-terraform-verify.sh

## Kubernetes client installation
ADD install-kubectl-prereqs.sh .
RUN ./install-kubectl-prereqs.sh
ADD install-kubectl.sh .
RUN ./install-kubectl.sh .
ADD install-kubectl-verify.sh .
RUN ./install-kubectl-verify.sh .

# Azure CLI
#RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#RUN apt-get install -y python3-pip --no-install-recommends
#RUN pip3 install azure-cli --break-system-packages
RUN apt-get -y install azure-cli --no-install-recommends
ADD install-az-verify.sh .
RUN ./install-az-verify.sh .

#ADD install-minikube-prereqs.sh .
#RUN ./install-terraform-prereqs.sh
ADD install-minikube.sh .
RUN ./install-minikube.sh
ADD install-minikube-verify.sh .
RUN ./install-minikube-verify.sh

## USER INITIALIZATION

RUN apt-get -y install neovim --no-install-recommends

USER neo
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "
# Enabling some default plugins. Might be moved later
RUN sed -i 's/^plugins=.*/plugins=(git kubectl azure terraform)/g' $HOME/.zshrc

# Install oh-my-zsh
# ADD install-ohmyzsh-prereqs.sh .
# RUN ./install-ohmyzsh-prereqs.sh
# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "
# RUN chsh -s /usr/bin/zsh
# Enabling some default plugins. Might be moved later
# RUN sed -i 's/^plugins=.*/plugins=(git kubectl azure terraform)/g' $HOME/.zshrc
# WORKDIR /git
