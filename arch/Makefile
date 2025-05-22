DOCKER_BASEIMAGE ?= oh-my-devops

build:
	docker build . --no-cache --pull -t $(DOCKER_BASEIMAGE)-wsl

wslexport:
	docker create --name tmpcontainer $(DOCKER_BASEIMAGE)-wsl
	docker export --output arch.tar tmpcontainer
	docker rm tmpcontainer
