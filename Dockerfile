ARG BASEOS=debian
FROM $BASEOS
RUN apt-get update
RUN apt-get install -y sudo

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

# Azure CLI installation
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
ADD install-az-verify.sh .
RUN ./install-az-verify.sh .

#ADD install-minikube-prereqs.sh .
#RUN ./install-terraform-prereqs.sh
ADD install-minikube.sh .
RUN ./install-minikube.sh
ADD install-minikube-verify.sh .
RUN ./install-minikube-verify.sh

# Install oh-my-zsh
ADD install-ohmyzsh-prereqs.sh .
RUN ./install-ohmyzsh-prereqs.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "

#TODO: Add Docker installation