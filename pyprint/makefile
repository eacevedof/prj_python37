# 4.19.76-linuxkit
build:
	docker-compose up -d --build

rebuild:
	make down
	make build

restart:
	docker-compose restart
	# make ssh

down:
	docker-compose down

ssh: ## bin/sh para alpine
	docker exec --user="root" -it cont-py38 /bin/bash

start:
	docker-compose start 
	#make ssh
stop: 
	docker-compose stop	

remove:
	docker rm cont-py38

logs:
	# docker logs cont-py38
	docker-compose logs --tail="all"

remlogs:
	rm -fr pyprint/logs/*
