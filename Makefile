build-docker-image:
	@echo "building docker image"
	docker build -t crabby_trade:latest -f Dockerfile.dev .
	@echo "built docker image!"

run-interactive: build-docker-image
	@echo "running docker image, interactive"
	docker run -v $(realpath .):/crab_trade -it crabby_trade /bin/bash

run-tests: build-docker-image
	@echo "running tests"
	docker run -v $(realpath .):/crab_trade crabby_trade cargo test

build-docs: build-docker-image
	@echo "building docs"
	docker run -v $(realpath .):/crab_trade crabby_trade cargo doc --no-deps --document-private-items
