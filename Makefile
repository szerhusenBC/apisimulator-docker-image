DOCKER_IMAGE=szerhusenbc/apisimulator
DOCKER_VERSION=1.12
DOCKER_CONTAINER_NAME=apisimulator

# Misc
.DEFAULT_GOAL = help

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

docker-build: ## Build the Docker image
	@echo "Building docker image..."
	@docker build -t $(DOCKER_IMAGE):latest .
	@docker tag $(DOCKER_IMAGE):latest $(DOCKER_IMAGE):$(DOCKER_VERSION)

docker-clean: ## Remove the Docker image
	@echo "Removing docker image and unused images..."
	@docker system prune -f
	@docker rmi $(DOCKER_IMAGE):latest
	@docker rmi $(DOCKER_IMAGE):$(DOCKER_VERSION)

docker-run: ## Run the Docker image
	@echo "Running docker image..."
	@docker run --rm -d -p 6090:6090 --name ${DOCKER_CONTAINER_NAME} $(DOCKER_IMAGE):latest

docker-exec: ## Enter the running Docker container
	@echo "Enter docker container..."
	@docker exec -it $(DOCKER_CONTAINER_NAME) bash

docker-stop: ## Stop the running Docker container
	@echo "Stopping docker container..."
	@docker stop $(DOCKER_CONTAINER_NAME)

docker-push: ## Push the Docker container
	@echo "Pushing docker container..."
	@docker push $(DOCKER_IMAGE):latest
	@docker push $(DOCKER_IMAGE):$(DOCKER_VERSION)
