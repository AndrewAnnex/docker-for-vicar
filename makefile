# Define image names
UBUNTU_IMAGE_NAME=vicar:ubuntu
CENTOS_IMAGE_NAME=vicar:centos

# Define container names
UBUNTU_CONTAINER_NAME=vicar:ubuntu:test
CENTOS_CONTAINER_NAME=vicar:centos:test

# Specify AMD64 platform, will later allow easier cross arch builds I think without messing with dockerfiles
PLATFORM=linux/amd64

.DEFAULT_GOAL := all

# Default target
all: build run_tests

# Build Docker images
build: build_ubuntu build_centos

build_ubuntu:
	docker buildx build --force-rm -f Dockerfile.ubuntu -t $(UBUNTU_IMAGE_NAME) --platform $(PLATFORM) .

build_centos:
	docker buildx build --force-rm -f Dockerfile.centos -t $(CENTOS_IMAGE_NAME) --platform $(PLATFORM) .

# Run tests in containers
run_tests: test_ubuntu test_centos

test_ubuntu:
	docker run --rm --platform $(PLATFORM) --name $(UBUNTU_CONTAINER_NAME) $(UBUNTU_IMAGE_NAME) -w /data/ ./vicar_tests.sh

test_centos:
	docker run --rm --platform $(PLATFORM) --name $(CENTOS_CONTAINER_NAME) $(CENTOS_IMAGE_NAME) -w /data/ ./vicar_tests.sh

# Clean up Docker images
clean:
	docker rmi $(UBUNTU_IMAGE_NAME) $(CENTOS_IMAGE_NAME)

.PHONY: all build build
