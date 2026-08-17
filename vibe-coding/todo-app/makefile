#!/bin/bash
# Atajos del proyecto. `make help` los lista todos.
#
# Si acabas de clonar/copiar esto, el orden es:
#   make venv-install     (una vez)
#   cp backend_web/.env.example backend_web/.env
#   make local

PY := .venv/bin/python
DC := docker compose -f docker/docker-compose-local.yml

# ---------------------------------------------------------------------------
# PUERTOS. Todos en el rango 6000-6999, para no chocar con el 8000/8080, que
# suele estar cogido por otra cosa.
#
# OJO al elegir numeros en este rango: los navegadores BLOQUEAN el 6000 (X11),
# el 6665-6669 y el 6697 (IRC). Una pagina servida ahi da ERR_UNSAFE_PORT y no
# abre. Por eso se empieza en 6001.
#
# API_PORT es tambien el puerto DENTRO del contenedor, para no tener dos numeros
# distintos que cuadrar.
API_PORT := 6001
FRONT_PORT := 6002
DEPLOY_PORT := 6003
EPHEMERAL_PORT := 6004

# Credencial del contenedor efimero. No es un secreto y no hace falta que lo sea:
# ese contenedor no guarda nada y muere al pararlo.
EPHEMERAL_API_KEY := ephemeral-local-key

help: ## muestra esta ayuda
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

venv-install: ## crea el venv e instala las dependencias del backend
	python3 -m venv .venv
	$(PY) -m pip install --upgrade pip
	$(PY) -m pip install -r backend_web/requirements.txt

local: ## arranca la API en el host, con recarga automatica (http://127.0.0.1:6001)
	cd backend_web && ../$(PY) -m uvicorn public.main:app --host 0.0.0.0 --port $(API_PORT) --reload

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

up-local: ## arranca la API en un contenedor (solo API; el front va aparte con front-local)
	$(DC) up --build

down-local: ## para el contenedor local
	$(DC) down

up-ephemeral: ## levanta el to-do ENTERO en un contenedor EFIMERO: no pide nada y no deja nada (Ctrl-C y desaparece)
	@echo "construyendo la imagen..."
	@docker build -q -f docker/Dockerfile-deploy -t todo-app:ephemeral . > /dev/null
	@echo
	@echo "  to-do en  ->  http://localhost:$(EPHEMERAL_PORT)"
	@echo "  apikey    ->  $(EPHEMERAL_API_KEY)"
	@echo
	@echo "  curl -H 'X-Api-Key: $(EPHEMERAL_API_KEY)' localhost:$(EPHEMERAL_PORT)/api/lists"
	@echo
	@echo "  Ctrl-C para pararlo. No queda contenedor, ni base de datos, ni logs."
	@echo
	docker run --rm -it \
		-p $(EPHEMERAL_PORT):$(API_PORT) \
		-e APP_ENV=local \
		-e API_KEY=$(EPHEMERAL_API_KEY) \
		--name cont-local-todo-app-ephemeral \
		todo-app:ephemeral

up-deploy-local: ## construye la imagen de DESPLIEGUE (front + API juntos) y la arranca en local, en el 6003
	docker build -f docker/Dockerfile-deploy -t todo-app:local .
	docker run --rm -p $(DEPLOY_PORT):$(API_PORT) \
		-v "$(PWD)/backend_web/.env:/app/backend_web/.env" \
		-v "$(PWD)/backend_web/storage:/app/backend_web/storage" \
		--name cont-local-todo-app-deploy todo-app:local

front-install: ## instala las dependencias del front
	cd frontend_web && npm install

front-local: ## arranca el front en local, con recarga automatica (http://localhost:6002)
	cd frontend_web && npm run local

front-build: ## compila el front comprobando tipos (falla si hay errores de TypeScript)
	cd frontend_web && npm run build

gitpush: ## git add + commit + push. Uso: make gitpush m="feat: lo que sea"
	git add . ; git commit -m "todo-app: $(m)" ; git push
