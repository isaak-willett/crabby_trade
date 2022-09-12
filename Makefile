build-docker-image:
	@echo "building docker image"
	docker build -t crabby_trade -f Dockerfile.dev .
	@echo "built docker image!"

run-interactive:
	@echo "running docker image, interactive"
	docker run -it crabby_trade /bin/bash
