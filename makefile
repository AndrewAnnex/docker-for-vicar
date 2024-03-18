# Define image names
UBUNTU_IMAGE_NAME ?= vicar:ubuntu

# Define container names
UBUNTU_CONTAINER_NAME ?= vicar_ubuntu_test

# Specify AMD64 platform, will later allow easier cross arch builds I think without messing with dockerfiles
PLATFORM=linux/amd64

.DEFAULT_GOAL := all

# Default target
all: build compile

# Build Docker images
build: build_ubuntu

build_ubuntu:
	docker buildx build --force-rm -f Dockerfile.ubuntu -t $(UBUNTU_IMAGE_NAME) --platform $(PLATFORM) .

# Run tests in containers
run_tests: test_ubuntu

test_ubuntu:
	docker run --rm -w /data/ --platform $(PLATFORM) --name $(UBUNTU_CONTAINER_NAME) $(UBUNTU_IMAGE_NAME) /data/vicar_tests.sh

# Clean up Docker images
clean:
	docker rmi $(UBUNTU_IMAGE_NAME)

.PHONY: all build compile_vicar build_ubuntu run_tests test_ubuntu compile clean

