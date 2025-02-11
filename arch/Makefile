DOCKER_BASEIMAGE ?= oh-my-devops

build:
	docker build . -t $(DOCKER_BASEIMAGE)-wsl

#wsl:
#	docker build images/base -t $(DOCKER_BASEIMAGE)-wsl --build-arg BASEOS=debian:unstable

#wsl-arch:
#	docker build images/base -t $(DOCKER_BASEIMAGE)-wsl --build-arg BASEOS=archlinux:latest

wslexport:
	docker create --name tmpcontainer $(DOCKER_BASEIMAGE)-wsl
	docker export --output arch.tar tmpcontainer
	docker rm tmpcontainer
