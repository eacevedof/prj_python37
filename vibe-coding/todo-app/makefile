#!/bin/bash
# Atajos del proyecto. `make help` los lista todos.
#
# Si acabas de clonar/copiar esto, el orden es:
#   make venv-install     (una vez)
#   cp backend_web/.env.example backend_web/.env
#   make dev

PY := .venv/bin/python
DC := docker compose -f docker/docker-compose.yml

help: ## muestra esta ayuda
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

venv-install: ## crea el venv e instala las dependencias del backend
	python3 -m venv .venv
	$(PY) -m pip install --upgrade pip
	$(PY) -m pip install -r backend_web/requirements.txt

dev: ## arranca la API en el host, con recarga automatica (http://127.0.0.1:8000)
	cd backend_web && ../$(PY) -m uvicorn public.main:app --host 0.0.0.0 --port 8000 --reload

check: ## ruff + mypy + pytest. SI ESTO ESTA VERDE, EL PATRON SE RESPETO.
	@echo "--- ruff (lint) ---"
	$(PY) -m ruff check backend_web
	@echo "--- ruff (formato) ---"
	$(PY) -m ruff format --check backend_web
	@echo "--- mypy (tipos, strict) ---"
	$(PY) -m mypy
	@echo "--- pytest ---"
	cd backend_web && ../$(PY) -m pytest
	@echo "--- TODO VERDE ---"

test: ## solo los tests
	cd backend_web && ../$(PY) -m pytest

format: ## reescribe el codigo con el formato del proyecto (arregla lo que ruff format se queja)
	$(PY) -m ruff format backend_web
	$(PY) -m ruff check --fix backend_web

db-fresh: ## BORRA la base de datos local. El siguiente arranque la reconstruye con las migraciones.
	rm -f backend_web/storage/database/*.db backend_web/storage/database/*.db-wal backend_web/storage/database/*.db-shm
	@echo "base de datos borrada; arranca la app para recrearla"

up: ## arranca la API en un contenedor (compose local)
	$(DC) up --build

down: ## para el contenedor
	$(DC) down

front-install: ## instala las dependencias del front
	cd frontend_web && npm install

front-dev: ## arranca el front en modo desarrollo (http://localhost:5173)
	cd frontend_web && npm run dev

front-build: ## compila el front comprobando tipos (falla si hay errores de TypeScript)
	cd frontend_web && npm run build

gitpush: ## git add + commit + push. Uso: make gitpush m="feat: lo que sea"
	git add . ; git commit -m "todo-app: $(m)" ; git push
