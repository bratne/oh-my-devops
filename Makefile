DOCKER_BASEIMAGE ?= oh-my-devops
DOCKER_WSLNAME ?= oh-my-devops-wsl

devcontainer:
	docker build images/base -t $(DOCKER_BASEIMAGE) --build-arg BASEOS=mcr.microsoft.com/devcontainers/base:debian	                                                            
build:
	docker build images/base -t $(DOCKER_BASEIMAGE)
	docker build images/with-node -t $(DOCKER_NODEIMAGE)
clean:
	docker image rm $(DOCKER_NODEIMAGE)
	docker image rm $(DOCKER_BASEIMAGE)

wsl:
	docker build images/base -t $(DOCKER_BASEIMAGE)-wsl --build-arg BASEOS=debian:unstable

wslexport:
	docker run --name wsl_export $(DOCKER_BASEIMAGE)-wsl
	docker export wsl_export > debian_unstable.tar
	docker rm wsl_export
