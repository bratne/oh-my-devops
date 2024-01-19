ARG BASEOS=debian
ARG SHDIR=src
FROM $BASEOS
RUN apt-get update
RUN apt-get install -y sudo --no-install-recommends

## Terraform installation
ADD $SHDIR/install-terraform-prereqs.sh .
RUN ./install-terraform-prereqs.sh
ADD $SHDIR/install-terraform.sh .
RUN ./install-terraform.sh
ADD $SHDIR/install-terraform-verify.sh .
RUN ./install-terraform-verify.sh

## Kubernetes client installation
ADD $SHDIR/install-kubectl-prereqs.sh .
RUN ./install-kubectl-prereqs.sh
ADD $SHDIR/install-kubectl.sh .
RUN ./install-kubectl.sh .
ADD $SHDIR/install-kubectl-verify.sh .
RUN ./install-kubectl-verify.sh .

# Azure CLI
#RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
RUN apt-get install -y python3-pip --no-install-recommends
RUN pip3 install azure-cli --break-system-packages
ADD $SHDIR/install-az-verify.sh .
RUN ./install-az-verify.sh .

#ADD install-minikube-prereqs.sh .
#RUN ./install-terraform-prereqs.sh
ADD $SHDIR/install-minikube.sh .
RUN ./install-minikube.sh
ADD $SHDIR/install-minikube-verify.sh .
RUN ./install-minikube-verify.sh

# Install oh-my-zsh
ADD $SHDIR/install-ohmyzsh-prereqs.sh .
RUN ./install-ohmyzsh-prereqs.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "

#TODO: Add Docker installation
