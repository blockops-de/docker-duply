ROOT_DIR := $(shell pwd)
PROJECT_NAME := $(notdir $(ROOT_DIR))
RELEASE_VERSION ?= $(shell git describe)
RELEASE_DATE := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')

IMAGE_REGISTRY := docker.io
IMAGE_NAME := xeroc/$(PROJECT_NAME)
DOCKER_BUILD_ARGS := --build-arg BUILD_DATE=$(RELEASE_DATE) --build-arg VCS_REF=$(RELEASE_VERSION)

.PHONY: docker
docker: docker_build docker_publish

.PHONY: docker_build
docker_build:
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_ARGS) -t $(IMAGE_REGISTRY)/$(IMAGE_NAME):${RELEASE_VERSION} .

.PHONY: docker_publish
docker_publish:
	docker push $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(RELEASE_VERSION)
	docker tag $(IMAGE_REGISTRY)/$(IMAGE_NAME):$(RELEASE_VERSION) $(IMAGE_REGISTRY)/$(IMAGE_NAME):latest
	docker push $(IMAGE_REGISTRY)/$(IMAGE_NAME):latest
