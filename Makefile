DOCKER_BASEIMAGE ?= oh-my-devops
DOCKER_VSCODEIMAGE ?= oh-my-devops-vscode
DOCKER_NODEIMAGE ?= oh-my-devops-node

devcontainer:
	docker build images/base -t $(DOCKER_VSCODEIMAGE) --build-arg BASEOS=mcr.microsoft.com/devcontainers/base:debian	                                                            
build:
	docker build images/base -t $(DOCKER_BASEIMAGE)
	docker build images/with-node -t $(DOCKER_NODEIMAGE)
clean:
	docker image rm $(DOCKER_NODEIMAGE)
	docker image rm $(DOCKER_BASEIMAGE)
