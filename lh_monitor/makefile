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

dashboard: ## Run dashboard
	clear;
	@echo $(NOW)

	@export PYTHONPATH="${PYTHONPATH}:${PATHPRJ}/prj_python37"
	@cd $(PATHPRJ)/prj_python37/lh_monitor; \
	$(PIPENV_VENV_IN_PROJECT)/prj_python37/bin/python -m lh_monitor.dashboard