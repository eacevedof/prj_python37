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

uvicorn: ## lines to start uvicorn server
	@echo "C:\projects\prj_python37\wa-chtgpt\venv\Scripts\activate"
	@echo "cd C:\projects\prj_python37\wa-chtgpt\wa-chatgpt"
	@echo "uvicorn main:app --reload --host 127.0.0.1 --port 5000"

vue: ## run vue
	@echo "cd fe-vue && npm run serve"