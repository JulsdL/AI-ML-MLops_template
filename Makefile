# Basic Makefile for Poetry + Docker + Testing

# Variables
APP_NAME = astronomy-ml-project
DOCKER_IMAGE = $(APP_NAME):latest
PROJECT_DIR = /app

# Default target
.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  install       Install dependencies with Poetry"
	@echo "  update        Update dependencies with Poetry"
	@echo "  lint          Run linting (flake8/pylint optional)"
	@echo "  test          Run tests with pytest"
	@echo "  run           Run the application (example: training script)"
	@echo "  docker-build  Build the Docker image"
	@echo "  docker-run    Run the Docker container"
	@echo "  clean         Remove build artifacts"

.PHONY: install
install:
	@echo "Installing dependencies..."
	poetry install

.PHONY: update
update:
	@echo "Updating dependencies..."
	poetry update

.PHONY: lint
lint:
	@echo "Running lint..."
	@# Install flake8 or pylint in dev dependencies if needed
	# e.g., poetry run flake8 src tests

.PHONY: test
test:
	@echo "Running tests with pytest..."
	poetry run pytest --maxfail=1 --disable-warnings -q

.PHONY: run
run:
	@echo "Running main training script..."
	poetry run python src/models/train.py

.PHONY: docker-build
docker-build:
	@echo "Building Docker image..."
	docker build -t $(DOCKER_IMAGE) .

.PHONY: docker-run
docker-run:
	@echo "Running Docker container..."
	docker run -it -p 8888:8888 --name $(APP_NAME) $(DOCKER_IMAGE)

.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -rf build dist *.egg-info
