# 4.19.76-linuxkit
build:
	docker-compose up -d --build

rebuild:
	make down
	make build

restart:
	docker-compose restart
	make ssh

down:
	docker-compose down

ssh:
	docker exec --user="root" -it cont-py38 bash

start:
	docker-compose start 
	make ssh
stop: 
	docker-compose stop	