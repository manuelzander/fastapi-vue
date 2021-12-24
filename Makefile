all: build run

.PHONY: build run bash-backend bash-frontend bash-db logs-backend logs-frontend logs-db migrate psql stop clean-all

SHELLFLAGS=-euo pipefail -c

build:
	docker-compose build

run:
	docker-compose up -d --build

bash-backend: run
	docker exec -it fastapi-vue_backend_1 bash

bash-frontend: run
	docker exec -it fastapi-vue_frontend_1 bash

bash-db: run
	docker exec -it fastapi-vue_db_1 bash

logs-backend: run
	docker logs --follow fastapi-vue_backend_1

logs-frontend: run
	docker logs --follow fastapi-vue_frontend_1

logs-db: run
	docker logs --follow fastapi-vue_db_1

migrate: run
	docker-compose exec backend aerich upgrade

psql:
	docker exec -it fastapi-vue_db_1 psql -U hello_fastapi -d hello_fastapi_dev

stop:
	docker-compose down

clean-all:
	docker-compose down --rmi all
	docker volume prune
