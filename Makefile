DOCKER_BASEIMAGE ?= oh-my-devops
DOCKER_NODEIMAGE ?= oh-my-devops-node

build:
	docker build images/base -t $(DOCKER_BASEIMAGE)
	docker build images/with-node -t $(DOCKER_NODEIMAGE)
clean:
	docker image rm $(DOCKER_NODEIMAGE)
	docker image rm $(DOCKER_BASEIMAGE)