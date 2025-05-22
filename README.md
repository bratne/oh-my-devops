# oh-my-devops

## Intro

Making this tiny repository to bootstrap the tools I need for everyday development. Initially designed to work with the newest Debian 12, and probably Ubuntu as well. Needs some testing and automation. The goal is to be able to simplify and autotest installation of my tools.

## Goal

Being able to run a single script to make a working machine with a dev env I feel at home with.

## Tools being installed

* Base image - "oh-my-devops"

    * [Git](https://git-scm.com/)
    * [OhmyZsh](https://ohmyz.sh/)
    * [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
    * [Terraform](https://www.terraform.io/)
    * [Kubernetes](https://kubernetes.io/docs/home/)
    * [Minikube](https://minikube.sigs.k8s.io/docs/)

* Node image - "oh-my-devops-node"

    * [Node Version Manager](https://github.com/nvm-sh/nvm)
    * [Node.js](https://nodejs.org/en)
    * [npm](https://docs.npmjs.com/about-npm/)
    * [Yarn](https://yarnpkg.com/)
    
## Building

    make build

## Individual images

### Base image

    cd images/base
    docker build -t oh-my-devops .

    sudo docker run --rm --name mydev -it -v /var/run/docker.sock:/var/run/docker.sock --entrypoint /bin/zsh oh-my-devops

### NPM image

    cd images/with-node
    docker build -t oh-my-devops-node .

### Arch and WSL

    cd arch
    make 
    make wslexport
    export tmpfolder=/mnt/c/Users/[my-username]/temp
    mkdir -p $tmpfolder
    cp arch.tar $tmpfolder
    # Start Windows CMD
    cd C:\users\[my-username]\temp
