ARG BASEOS=debian:unstable
FROM $BASEOS
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y sudo --no-install-recommends

WORKDIR /src

# Install terraform
RUN apt-get install -y terraform-switcher

# Install kubectl
ADD install-kubectl-prereqs.sh .
RUN ./install-kubectl-prereqs.sh
ADD install-kubectl.sh .
RUN ./install-kubectl.sh .
# ADD install-kubectl-verify.sh .
# RUN ./install-kubectl-verify.sh .

# Azure CLI
#RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#RUN apt-get install -y python3-pip --no-install-recommends
#RUN pip3 install azure-cli --break-system-packages
# RUN apt-get -y install azure-cli --no-install-3recommends
# RUN apt-get -y install python3-pip --no-install-recommends
# RUN pip3 install azure-cli
#RUN apt-get -y install python3-azure-cli-core --no-install-recommends
#RUN apt-get -y install python3-azure-cli-core --no-install-recommends
RUN apt-get -y install azure-cli --no-install-recommends

## USER INITIALIZATION

RUN apt-get -y install neovim --no-install-recommends

RUN apt-get -y install zsh --no-install-recommends
RUN apt-get -y install git --no-install-recommends
RUN apt-get -y install jq --no-install-recommends
RUN apt-get -y install yq --no-install-recommends

RUN ZDOTDIR="/etc/skel" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "
# Enabling some default plugins. Might be moved later
#RUN sed -i 's/^plugins=.*/plugins=(git kubectl azure terraform)/g' $HOME/.zshrc

# Install oh-my-zsh
# ADD install-ohmyzsh-prereqs.sh .
# RUN ./install-ohmyzsh-prereqs.sh

# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "
# RUN chsh -s /usr/bin/zsh
# Enabling some default plugins. Might be moved later
# RUN sed -i 's/^plugins=.*/plugins=(git kubectl azure terraform)/g' $HOME/.zshrc
WORKDIR /tmp

RUN az version -o json
RUN SOMEVAR=$(date); az extension add --name azure-devops --debug

COPY required_tools.yaml .
COPY verify-tools.sh .
# RUN chmod a+x ./verify-tools.sh
RUN echo $PATH
RUN ./verify-tools.sh required_tools.yaml
