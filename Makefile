all: build run

.PHONY: build run bash-backend bash-frontend logs-backend logs-frontend clean-all

SHELLFLAGS=-euo pipefail -c

build:
	docker-compose build

run:
	docker-compose up -d --build

bash-backend:
	docker exec -it fastapi-vue_backend_1 bash

bash-frontend:
	docker exec -it fastapi-vue_frontend_1 bash

logs-backend:
	docker logs --follow fastapi-vue_backend_1

logs-frontend:
	docker logs --follow fastapi-vue_frontend_1

clean-all:
	docker-compose down --rmi all