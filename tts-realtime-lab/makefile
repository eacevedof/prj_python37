#!/bin/bash
PY := .venv/Scripts/python.exe

help: ## Show this help message
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

install: ## create .venv (python 3.13) and install requirements
	py -3.13 -m venv .venv
	$(PY) -m pip install -U pip
	$(PY) -m pip install -r requirements.txt

lab: ## legacy vs realtime over the default battery
	$(PY) run_lab.py

lab-new: ## realtime only (no legacy calls)
	$(PY) run_lab.py --only-new

say: ## one text: make say t="Hoe gaat het?" v=marin
	$(PY) run_lab.py --only-new --text "$(t)" --voices $(or $(v),marin)
