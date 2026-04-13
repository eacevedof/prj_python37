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

