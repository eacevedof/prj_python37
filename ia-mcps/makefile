#!/bin/bash
TODAY := $(shell date +'%Y%m%d')
OS := $(shell uname)

DC := docker compose -f docker/docker-compose.yml
help: ## Show this help message
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

dev: ## arranca la app en el HOST (uvicorn --reload, lee backend_web/.env)
	cd backend_web && uvicorn public.main:app --host 127.0.0.1 --port 8010 --reload

up: ## arranca la app en CONTENEDOR (compose local, host:8011)
	$(DC) up --build

down: ## para el contenedor de la app
	$(DC) down

user-add: ## alta de usuario MCP: make user-add tg=<id-telegram> name=<nombre> [admin=1] [disabled=1]
	cd backend_web && python public/main_user_add.py "$(tg)" "$(name)" $(if $(admin),--admin,) $(if $(disabled),--disabled,)

user-update: ## edita un usuario: make user-update tg=<id> [name=<nombre>] [role=<1|2>] [enable=1] [disable=1] [password=1] [nopassword=1]
	cd backend_web && python public/main_user_update.py "$(tg)" $(if $(name),--name "$(name)",) $(if $(role),--role $(role),) $(if $(enable),--enable,) $(if $(disable),--disable,) $(if $(password),--password,) $(if $(nopassword),--no-password,)

test: ## run tests (pytest) desde backend_web
	cd backend_web && python -m pytest

lint: ## ruff + mypy sobre backend_web
	cd backend_web && ruff check . && mypy src public

gitpush: ## git push m=any message
	clear;
	git add .; git commit -m "ia-mcps: $(m)"; git push;

gp-def: ## git push with default ia-mcps message
	clear;
	git add .; git commit -m "ia-mcps"; git push;

CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
update-branch:  ## update master branch
	git fetch --all;
	git checkout develop; git reset --hard origin/develop;
	git checkout master; git reset --hard origin/master;

	git checkout $(CURRENT_BRANCH);
	git diff --name-only develop master

venv: ## cómo crear/activar el venv de backend_web (make NO puede activarlo: se pierde al salir de la subshell)
	@echo "# linux / wsl"
	@echo "python3 -m venv .venv-wsl && source .venv-wsl/bin/activate"
	@echo "pip install --upgrade pip && pip install -r backend_web/requirements.txt"
	@echo ""
	@echo "# windows"
	@echo "py -3.13 -m venv .venv-win && .venv-win\\Scripts\\activate"
	@echo ".venv-win\\Scripts\\python.exe -m pip install -r backend_web/requirements.txt"
	@echo ""
	@echo "# weasyprint (pdf_mod) necesita librerias nativas del sistema:"
	@echo "# debian/ubuntu -> sudo apt install libcairo2 libpango-1.0-0 libpangoft2-1.0-0"
	@echo "# windows       -> GTK3 Runtime"
