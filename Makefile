all: build run

.PHONY: build run bash-backend bash-frontend bash-db logs-backend logs-frontend logs-db migrate psql clean-all

SHELLFLAGS=-euo pipefail -c

build:
	docker-compose build

run:
	docker-compose up -d --build

bash-backend:
	docker exec -it fastapi-vue_backend_1 bash

bash-frontend:
	docker exec -it fastapi-vue_frontend_1 bash

bash-db:
	docker exec -it fastapi-vue_db_1 bash

logs-backend:
	docker logs --follow fastapi-vue_backend_1

logs-frontend:
	docker logs --follow fastapi-vue_frontend_1

logs-db:
	docker logs --follow fastapi-vue_db_1

migrate:
	docker-compose exec backend aerich upgrade

psql:
	docker exec -it fastapi-vue_db_1 psql -U hello_fastapi -d hello_fastapi_dev

clean-all:
	docker-compose down --rmi all