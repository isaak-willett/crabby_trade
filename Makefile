build-docker-image:
	@echo "building docker image"
	docker build -t crabby_trade:latest -f Dockerfile.dev .
	@echo "built docker image!"

run-interactive:
	@echo "running docker image, interactive"
	docker run -it crabby_trade /bin/bash

run-tests: build-docker-image
	@echo "running tests"
	docker run crabby_trade cargo test

build-docs: build-docker-image
	@echo "building docs"
	docker run crabby_trade cargo doc --no-deps --document-private-items
