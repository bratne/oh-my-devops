# oh-my-devops

## Intro

Making this tiny repository to bootstrap the tools I need for everyday development. Initially designed to work with the newest Debian 12, and probably Ubuntu as well. Needs some testing and automation. The goal is to be able to simplify and autotest installation of my tools.

## Goal

Being able to run a single script to make a working machine with a dev env I feel at home with.

## Tools being installed

* [Git](https://git-scm.com/)
* [OhmyZsh](https://ohmyz.sh/)
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
* [Terraform](https://www.terraform.io/)
* [Kubernetes](https://kubernetes.io/docs/home/)
* [Minikube](https://minikube.sigs.k8s.io/docs/)

## Building a local image with docker

docker build -t mydevenv .
sudo docker run --rm --name mydev -it -v /var/run/docker.sock:/var/run/docker.sock --entrypoint /bin/zsh mydevenv