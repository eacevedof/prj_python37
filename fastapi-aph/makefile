#!/bin/bash

help: ## Show this help message
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

gitpush: ## git push m=any message
	clear;
	git add .; git commit -m "$(m)"; git push;

gp: ## git push m=any message
	clear;
	git add .; git commit -m "$(m)"; git push;

CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
update-branch: ## update main branches
	git fetch --all;
	git checkout dev-eduardo; git reset --hard origin/dev-eduardo;
	git checkout preproduccion; git reset --hard origin/preproduccion;
	git checkout main; git reset --hard origin/main;
	git checkout $(CURRENT_BRANCH);
	git diff preproduccion main --name-only

# Python Environment Commands
install: ## Install Python dependencies
	clear;
	pip install -r requirements.txt

install-dev: ## Install development dependencies
	clear;
	pip install -r requirements.txt
	pip install pytest pytest-asyncio black flake8 mypy

venv: ## Create virtual environment
	clear;
	python -m venv venv
	@echo "Activate with: source venv/bin/activate (Linux/Mac) or venv\\Scripts\\activate (Windows)"

format: ## Format code with black
	clear;
	black app/ --line-length 100

lint: ## Lint code with flake8
	clear;
	flake8 app/ --max-line-length=100 --ignore=E203,W503

typecheck: ## Type check with mypy
	clear;
	mypy app/ --ignore-missing-imports

# Console Commands (equivalent to Deno tasks)
py-check-app: ## python console.py lz:check-app
	clear;
	python console.py lz:check-app

py-check-ftp: ## python console.py lz:check-ftp
	clear;
	python console.py lz:check-ftp

py-check-email: ## python console.py lz:check-email
	clear;
	python console.py lz:check-email

py-etl-risky-domains: ## python console.py lz:etl-risky-domains
	clear;
	cat .env; python console.py lz:etl-risky-domains

py-etl-refresh-redis: ## python console.py lz:etl-refresh-redis
	clear;
	cat .env; python console.py lz:etl-refresh-redis

py-deploy: ## python console.py lz:deploy
	clear;
	cat .env; python console.py lz:deploy

# Development Commands
py-dev: ## Run FastAPI development server with auto-reload
	clear;
	python --version
	uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

py-start: ## Run FastAPI production server
	clear;
	python --version
	uvicorn app.main:app --host 0.0.0.0 --port 8000

py-tests: ## Run pytest tests
	clear;
	python --version
	pytest -v

py-tests-debug: ## Run pytest with debug output
	clear;
	python --version
	pytest -v -s --tb=long

py-tests-coverage: ## Run pytest with coverage report
	clear;
	python --version
	pytest --cov=app --cov-report=html --cov-report=term

# Health Check
py-health: ## curl health-check endpoint
	clear;
	curl --location 'http://localhost:8000/v1/health-check' | python -m json.tool

# Docker Commands
py-docker-build: ## Build Docker image
	clear;
	docker build -t py-fast-api .

py-docker-run: ## Run Docker container
	clear;
	docker run -d -p 8000:8000 --name py-fast-api-container py-fast-api

py-docker-stop: ## Stop Docker container
	clear;
	docker stop py-fast-api-container
	docker rm py-fast-api-container

py-docker-test: ## Test Docker build and run
	clear;
	docker rm -f py-fast-api-test;
	docker rmi -f py-fast-api-test;
	docker build -t py-fast-api-test .;
	docker run -d -p 8001:8000 --name py-fast-api-test py-fast-api-test;
	sleep 5;
	curl --location 'http://localhost:8001/v1/health-check' | python -m json.tool

# Database Commands
db-migrate: ## Run database migrations (if implemented)
	clear;
	python console.py lz:deploy

# Utility Commands
clean: ## Clean Python cache files
	clear;
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -name "*.pyc" -delete
	find . -name "*.pyo" -delete
	find . -name "*.pyd" -delete
	find . -name ".coverage" -delete
	rm -rf htmlcov/
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/

shell: ## Start Python REPL with app context
	clear;
	python -c "from app.main import app; import asyncio; print('FastAPI app available as: app')"

# Docker SSH equivalent (for container access)
ssh-py: ## Access Python container (if running in Docker)
	clear;
	docker exec -it py-fast-api-container bash

# Requirements management
freeze: ## Generate requirements.txt from current environment
	clear;
	pip freeze > requirements.txt

# Security scan
security-scan: ## Run security scan with bandit
	clear;
	bandit -r app/ -f json