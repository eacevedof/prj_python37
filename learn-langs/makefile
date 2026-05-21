#!/bin/bash
TODAY := $(shell date +'%Y-%m-%d')
CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

help: ## Show this help message
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

gitpush: ## git push m=any message
	clear;
	git add .; git commit -m "learn-lang $(m)"; git push;

gp-def: ## git push with default message
	clear;
	git add .; git commit -m "learn-lang"; git push;

CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
update-branch:  ## update master branch
	git fetch --all;
	git checkout develop; git reset --hard origin/develop;
	git checkout master; git reset --hard origin/master;

	git checkout $(CURRENT_BRANCH);
	git diff --name-only develop master

apk: ## build android apk
	@echo "Generating flet.yaml from .env..."
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "name: learn-langs" > flet.yaml
	@echo "description: Learn Languages App with Spaced Repetition" >> flet.yaml
	@echo "" >> flet.yaml
	@echo "environment:" >> flet.yaml
	@grep "^OPENAI_API_KEY=" .env | sed 's/^OPENAI_API_KEY=/  OPENAI_API_KEY: "/' | sed 's/$$/\"/' >> flet.yaml
	@grep "^APP_LOG_PATH=" .env | sed 's/^APP_LOG_PATH=/  APP_LOG_PATH: "/' | sed 's/$$/\"/' >> flet.yaml
	@echo "flet.yaml generated successfully"
	@mv requirements.txt requirements-dev.txt 2>/dev/null || true
	@cp requirements-prod.txt requirements.txt
	flet build apk --module-name front_controller --verbose
	@mv requirements-dev.txt requirements.txt 2>/dev/null || true

