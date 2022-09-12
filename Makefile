
version := $(shell cat VERSION)

build-docker-image:
	@echo "building docker image"
	docker build -t crabby_trade:${version} -f Dockerfile.dev .
	@echo "built docker image!"

build-cargo-package: build-docker-image
	@echo "building cargo crate"
	docker run -v $(realpath .):/crab_trade crabby_trade:${version} cargo build

build-docs: build-docker-image
	@echo "building docs"
	docker run -v $(realpath .):/crab_trade crabby_trade:${version} cargo doc --no-deps --document-private-items

run-interactive: build-docker-image
	@echo "running docker image, interactive"
	docker run -v $(realpath .):/crab_trade -it crabby_trade:${version} /bin/bash

run-clippy: build-docker-image
	@echo "running clippy"
	docker run -v $(realpath .):/crab_trade crabby_trade:${version} cargo clippy

run-tests: run-clippy
	@echo "running tests"
	docker run -v $(realpath .):/crab_trade crabby_trade:${version} cargo test

publish_crate: build-cargo-package
	@echo "publishing crate"
	docker run -v ${realpath .}:/crab_trade crabby_trade cargo:${version} publish --token ${CARGO_API_KEY} --allow-dirty