#!/bin/bash
TODAY := $(shell date +'%Y-%m-%d')
NOW := $(shell date +'%Y-%m-%d %H:%M:%S')

help: ## Show this help message
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

gitpush: ## git push m=any message
	clear;
	git add .; git commit -m "$(m)"; git push;

rebuild-all: ## rebuild all services containers in docker-compose
	docker-compose -f docker-compose.yml down
	docker-compose -f docker-compose.yml up -d --build --remove-orphans

lh-monitor: ## Run dashboard
	clear;
	@echo $(NOW)

	@export PYTHONPATH="${HOME}/projects/prj_python37/lh_monitor/lh_monitor"
	@cd ${HOME}/projects/prj_python37/lh_monitor/lh_monitor; \
	${HOME}/projects/prj_python37/lh_monitor/venv/bin/python -m main