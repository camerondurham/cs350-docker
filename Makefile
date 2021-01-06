.PHONY: build

# Default values for variables
REPO  			?= camerondurham/xv6-docker
TAG   			?= latest
CONTAINER_NAME 	?= xv6-test

build:
	docker build -t $(REPO):$(TAG) .


run:
	docker run --rm -d \
		-p 7776:22 \
		-p 7777:7777 \
		-p 25000:25000 \
		--privileged \
		--security-opt seccomp:unconfined \
		--name $(CONTAINER_NAME) \
		$(REPO):$(TAG)

shell:
	docker exec -it \
		$(CONTAINER_NAME) \
		/bin/bash

stop:
	docker stop $(CONTAINER_NAME)
