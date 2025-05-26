DOCKER_BASEIMAGE ?= oh-my-devops
TARFILE_FOLDER ?= .

build:
	docker build . -t $(DOCKER_BASEIMAGE)-wsl

rebuild:
	docker build . --no-cache --pull -t $(DOCKER_BASEIMAGE)-wsl

wslexport:
	docker create --name tmpcontainer $(DOCKER_BASEIMAGE)-wsl
	docker export --output $TARFILE_FOLDER/arch.tar tmpcontainer
	docker rm tmpcontainer
