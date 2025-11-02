GREEN=\033[0;32m
RED=\033[0;31m
YELLOW=\033[1;33m
NC=\033[0m

.PHONY: up down ps logs studio studio-up test

info = @echo "$(YELLOW)$(1)$(NC)"
success = @echo "$(GREEN)$(1)$(NC)"
error = @echo "$(RED)$(1)$(NC)"

DC=docker/docker-compose.yml
APP_SERVICE=app
POSTGRES_SERVICE=postgres

APP_PORT=3000
STUDIO_PORT=5555

TEST_WORKDIR=/usr/src/app

up:
	$(call info, Checking ports...)
	@if lsof -i :$(APP_PORT) >/dev/null 2>&1; then echo "Port $(APP_PORT) is in use. Please free it."; exit 1; fi
	@if lsof -i :$(STUDIO_PORT) >/dev/null 2>&1; then echo "Port $(STUDIO_PORT) is in use. Please free it."; exit 1; fi

	$(call info, Starting containers...)
	docker-compose --env-file .env -f $(DC) up --build -d

	$(call success, All services are up and ready!)

down:
	docker-compose --env-file .env -f $(DC) down -v --remove-orphans
	$(call success, Containers, volumes and networks removed.)

ps:
	docker-compose --env-file .env -f $(DC) ps

logs:
	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

test:
	$(call info, Running e2e tests inside Docker...)
	docker-compose run --rm -w $(TEST_WORKDIR) $(APP_SERVICE) yarn test:e2e









# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# DC=docker/docker-compose.yml
# APP_SERVICE=app
# STUDIO_SERVICE=prisma-studio
# POSTGRES_SERVICE=postgres

# APP_PORT=3000
# STUDIO_PORT=5555

# up:
# 	$(call info, Checking ports...)
# 	@if lsof -i :$(APP_PORT) >/dev/null 2>&1; then echo "Port $(APP_PORT) is in use. Please free it."; exit 1; fi
# 	@if lsof -i :$(STUDIO_PORT) >/dev/null 2>&1; then echo "Port $(STUDIO_PORT) is in use. Please free it."; exit 1; fi

# 	$(call info, Starting containers...)
# 	docker-compose --env-file .env -f $(DC) up --build -d

# 	$(call info, Waiting for app container to start...)
# 	sleep 5

# 	$(call info, Running Prisma generate...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate

# 	$(call info, Running Prisma migrations...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy

# 	$(call info, Running Prisma seed...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed

# 	$(call success, All services are up and database is ready!)

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, Containers stopped and volumes removed.)

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# studio:
# 	$(call info, Starting Prisma Studio...)
# 	docker-compose --env-file .env -f $(DC) up -d $(STUDIO_SERVICE)









# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# DC=docker/docker-compose.yml
# APP_SERVICE=app
# STUDIO_SERVICE=prisma-studio
# POSTGRES_SERVICE=postgres

# APP_PORT=3000
# STUDIO_PORT=5555

# up:
# 	$(call info, Checking ports...)
# 	@if lsof -i :$(APP_PORT) >/dev/null 2>&1; then echo "Port $(APP_PORT) is in use. Please free it."; exit 1; fi
# 	@if lsof -i :$(STUDIO_PORT) >/dev/null 2>&1; then echo "Port $(STUDIO_PORT) is in use. Please free it."; exit 1; fi

# 	$(call info, Starting containers...)
# 	docker-compose --env-file .env -f $(DC) up --build -d

# 	$(call info, Waiting for app container to start...)
# 	sleep 5

# 	$(call info, Running Prisma generate...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate

# 	$(call info, Running Prisma migrations...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy

# 	$(call info, Running Prisma seed...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed

# 	$(call success, All services are up and database is ready!)

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, Containers stopped and volumes removed.)

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# studio:
# 	$(call info, Starting Prisma Studio...)
# 	docker-compose --env-file .env -f $(DC) exec $(APP_SERVICE) yarn prisma studio

# studio-up:
# 	docker-compose --env-file .env -f $(DC) up -d $(STUDIO_SERVICE)








# DC=docker/docker-compose.yml
# APP_SERVICE=app
# STUDIO_SERVICE=prisma-studio

# APP_PORT=3000
# STUDIO_PORT=5555

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# check_port = \
# if lsof -i :$(1) >/dev/null 2>&1; then \
#   echo "Port $(1) is in use. Please free it and try again."; \
#   exit 1; \
# fi

# up:
# 	$(call info,"Checking ports...")
# 	$(call check_port,$(APP_PORT))
# 	$(call check_port,$(STUDIO_PORT))
# 	$(call info,"Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info,"Waiting for app container to start...")
# 	sleep 5
# 	$(call info,"Running Prisma generate...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate
# 	$(call info,"Running Prisma migrations...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy
# 	$(call info,"Running Prisma seed...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed
# 	$(call success,"All services are up and database is ready!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success,"Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs-app:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# logs-studio:
# 	docker-compose --env-file .env -f $(DC) logs -f $(STUDIO_SERVICE)

# studio:
# 	$(call info,"Starting Prisma Studio...")
# 	docker-compose --env-file .env -f $(DC) exec $(STUDIO_SERVICE) yarn prisma studio --port 5555 --hostname 0.0.0.0








# DC=docker/docker-compose.yml
# APP_SERVICE=app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo $(YELLOW)$(1)$(NC)
# success = @echo $(GREEN)$(1)$(NC)
# error = @echo $(RED)$(1)$(NC)

# up:
# 	$(call info, "Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info, "Waiting for app container to start...")
# 	sleep 5
# 	$(call info, "Running Prisma generate...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate
# 	$(call info, "Running Prisma migrations...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy
# 	$(call info, "Running Prisma seed...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed
# 	$(call success, "All services are up and database is ready!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, "Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# studio:
# 	$(call info, "Starting Prisma Studio...")
# 	docker-compose --env-file .env -f $(DC) up -d prisma-studio







# DC=docker/docker-compose.yml
# APP_SERVICE=app
# STUDIO_SERVICE=prisma-studio

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# up:
# 	$(call info, "Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info, "Waiting for app container to start...")
# 	sleep 5
# 	$(call info, "Running Prisma generate...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate
# 	$(call info, "Running Prisma migrations...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy
# 	$(call info, "Running Prisma seed...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed
# 	$(call success, "All services are up and database is ready!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, "Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# studio:
# 	$(call info, "Starting Prisma Studio...")
# 	docker-compose --env-file .env -f $(DC) up -d $(STUDIO_SERVICE)
# 	$(call success, "Prisma Studio should be available at http://localhost:5555")





# DC = docker/docker-compose.yml
# APP_SERVICE = app

# GREEN  = \033[0;32m
# RED    = \033[0;31m
# YELLOW = \033[1;33m
# NC     = \033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# up:
# 	$(call info, Starting containers...)
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info, Waiting for app container to start...)
# 	sleep 5
# 	$(call info, Running Prisma generate...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate
# 	$(call info, Running Prisma migrations...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy
# 	$(call info, Running Prisma seed...)
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed
# 	$(call success, All services are up and database is ready!)

# down:
# 	$(call info, Stopping and removing containers...)
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, Containers stopped, volumes removed.)

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# studio:
# 	$(call info, Starting Prisma Studio...)
# 	docker-compose --env-file .env -f $(DC) exec $(APP_SERVICE) yarn prisma studio









# DC=docker/docker-compose.yml
# APP_SERVICE=app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo $(YELLOW)$(1)$(NC)
# success = @echo $(GREEN)$(1)$(NC)
# error = @echo $(RED)$(1)$(NC)

# up:
# 	$(call info, "Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info, "Waiting for app container to start...")
# 	sleep 5
# 	$(call info, "Running Prisma generate...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma generate
# 	$(call info, "Running Prisma migrations...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma migrate deploy
# 	$(call info, "Running Prisma seed...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_SERVICE) yarn prisma db seed
# 	$(call success, "All services are up and database is ready!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, "Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_SERVICE)

# studio:
# 	$(call info, "Starting Prisma Studio...")
# 	docker-compose --env-file .env -f $(DC) exec $(APP_SERVICE) yarn prisma studio








# DC=docker/docker-compose.yml
# APP_CONTAINER=booking_app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# define info
# 	@echo "$(YELLOW)$(1)$(NC)"
# endef
# define success
# 	@echo "$(GREEN)$(1)$(NC)"
# endef
# define error
# 	@echo "$(RED)$(1)$(NC)"
# endef

# up:
# 	@echo "$(YELLOW)Starting containers...$(NC)"
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	@echo "$(GREEN)Containers started successfully!$(NC)"

# down:
# 	@echo "$(YELLOW)Stopping containers and removing volumes...$(NC)"
# 	docker-compose --env-file .env -f $(DC) down -v
# 	@echo "$(GREEN)Containers stopped and volumes removed.$(NC)"

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_CONTAINER)

# ps:
# 	docker-compose --env-file .env -f $(DC) ps




# DC=docker/docker-compose.yml
# APP_CONTAINER=booking_app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo $(YELLOW)$(1)$(NC)
# success = @echo $(GREEN)$(1)$(NC)
# error = @echo $(RED)$(1)$(NC)

# up:
# 	$(call info, "Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call success, "Containers started successfully!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, "Containers stopped and volumes removed.")

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_CONTAINER)

# ps:
# 	docker-compose --env-file .env -f $(DC) ps





# DC=docker/docker-compose.yml

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo \033[1;33m$(1)\033[0m
# success = @echo \033[0;32m$(1)\033[0m

# up:
# 	$(call info,"Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call success,"Containers started. App will initialize database automatically inside the container.")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success,"Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f app



# DC=docker/docker-compose.yml
# APP_CONTAINER=app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo \033[1;33m$(1)\033[0m
# success = @echo \033[0;32m$(1)\033[0m
# error = @echo \033[0;31m$(1)\033[0m

# up:
# 	$(call info, "Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info, "Waiting for app container to start...")
# 	sleep 5
# 	$(call info, "Running Prisma generate...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma generate
# 	$(call info, "Running Prisma migrations...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma migrate deploy
# 	$(call info, "Running Prisma seed...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma db seed
# 	$(call success, "All services are up and database is ready!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, "Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_CONTAINER)





# DC=docker/docker-compose.yml
# APP_CONTAINER=app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# up:
# 	$(call info, "Starting containers...")
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(call info, "Waiting for app container to start...")
# 	sleep 5
# 	$(call info, "Running Prisma generate...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma generate
# 	$(call info, "Running Prisma migrations...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma migrate deploy
# 	$(call info, "Running Prisma seed...")
# 	docker-compose --env-file .env -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma db seed
# 	$(call success, "All services are up and database is ready!")

# down:
# 	docker-compose --env-file .env -f $(DC) down -v
# 	$(call success, "Containers stopped, volumes removed.")

# ps:
# 	docker-compose --env-file .env -f $(DC) ps

# logs:
# 	docker-compose --env-file .env -f $(DC) logs -f $(APP_CONTAINER)




# DC=docker/docker-compose.yml
# APP_CONTAINER=app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m

# info = @echo "$(YELLOW)$(1)$(NC)"
# success = @echo "$(GREEN)$(1)$(NC)"
# error = @echo "$(RED)$(1)$(NC)"

# up:
# 	$(info) "Starting containers..."
# 	docker-compose --env-file .env -f $(DC) up --build -d
# 	$(info) "Waiting for app container to start..."
# 	sleep 5
# 	$(info) "Running Prisma generate..."
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma generate
# 	$(info) "Running Prisma migrations..."
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma migrate deploy
# 	$(info) "Running Prisma seed..."
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma db seed
# 	$(success) "All services are up and database is ready!"

# down:
# 	docker-compose -f $(DC) down -v
# 	$(success) "Containers stopped, volumes removed."

# ps:
# 	docker-compose -f $(DC) ps

# logs:
# 	docker-compose -f $(DC) logs -f $(APP_CONTAINER)




# DC=docker/docker-compose.yml
# APP_CONTAINER=app

# up:
# 	docker-compose -f $(DC) up --build -d
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma generate
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma migrate deploy
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) yarn prisma db seed
# 	@echo "\033[0;32m Все сервисы подняты, база и Prisma готовы\033[0m"

# down:
# 	docker-compose -f $(DC) down -v
# 	@echo "\033[0;31m Контейнеры остановлены, тома удалены\033[0m"

# ps:
# 	docker-compose -f $(DC) ps

# logs:
# 	docker-compose -f $(DC) logs -f app







# DC=docker/docker-compose.yml

# up:
# 	docker-compose -f $(DC) up --build -d
# 	@echo "\033[0;32m Сервисы подняты, база и Prisma готовы\033[0m"

# down:
# 	docker-compose -f $(DC) down -v
# 	@echo "\033[0;31m Контейнеры остановлены, тома удалены\033[0m"

# ps:
# 	docker-compose -f $(DC) ps

# logs:
# 	docker-compose -f $(DC) logs -f app





# DC=docker/docker-compose.yml
# APP_CONTAINER=app
# WORKDIR=/usr/src/app

# GREEN=\033[0;32m
# RED=\033[0;31m
# YELLOW=\033[1;33m
# NC=\033[0m  

# up:
# 	@echo "$(YELLOW)🚀 Поднимаем сервисы...$(NC)"
# 	docker-compose -f $(DC) up --build -d
# 	@echo "$(YELLOW)⏳ Ждём пока приложение будет готово...$(NC)"
# 	docker-compose -f $(DC) exec -w $(WORKDIR) $(APP_CONTAINER) sh -c "until nc -z localhost 3000; do sleep 1; done"
# 	@echo "$(GREEN)Контейнеры подняты, можно выполнять миграции и seed$(NC)"
# 	@echo "$(GREEN)Prisma migrate и seed выполняются через entrypoint.sh$(NC)"

# down:
# 	@echo "$(YELLOW) Останавливаем контейнеры и удаляем тома...$(NC)"
# 	docker-compose -f $(DC) down -v
# 	@echo "$(RED)Контейнеры остановлены, тома удалены$(NC)"

# ps:
# 	docker-compose -f $(DC) ps

# logs:
# 	docker-compose -f $(DC) logs -f $(APP_CONTAINER)








# DC=docker/docker-compose.yml

# APP_CONTAINER=app

# up:
# 	docker-compose -f $(DC) up --build -d
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) npx prisma generate
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) npx prisma migrate deploy
# 	docker-compose -f $(DC) exec -w /usr/src/app $(APP_CONTAINER) npx prisma db seed
# 	@echo "✅ Все сервисы подняты, база и Prisma готовы"

# down:
# 	docker-compose -f $(DC) down -v
# 	@echo "🛑 Контейнеры остановлены, тома удалены"

# ps:
# 	docker-compose -f $(DC) ps

# logs:
# 	docker-compose -f $(DC) logs -f app




# DOCKER_COMPOSE=docker/docker-compose.yml

# # Поднимаем все контейнеры и билдим их
# up:
# 	docker-compose -f $(DOCKER_COMPOSE) up --build -d
# 	@echo "✅ Containers are up"

# # Останавливаем контейнеры и удаляем тома
# down:
# 	docker-compose -f $(DOCKER_COMPOSE) down -v
# 	@echo "🛑 Containers are down"

# # Прогоняем миграции Prisma
# migrate:
# 	docker-compose -f $(DOCKER_COMPOSE) exec app npx prisma migrate deploy
# 	@echo "✅ Prisma migrations applied"

# # Прогоняем seed для базы данных
# seed:
# 	docker-compose -f $(DOCKER_COMPOSE) exec app npx prisma db seed
# 	@echo "✅ Prisma seed executed"

# # Поднимаем контейнеры + миграции + seed
# setup: up migrate seed
# 	@echo "🚀 Application is ready"

# # Открыть Prisma Studio
# studio:
# 	docker-compose -f $(DOCKER_COMPOSE) exec app npx prisma studio




# COMPOSE_FILE=docker/docker-compose.yml

# # === Основные команды ===
# up:
# 	docker-compose -f $(COMPOSE_FILE) up --build -d
# 	docker-compose -f $(COMPOSE_FILE) exec app npx prisma migrate deploy
# 	docker-compose -f $(COMPOSE_FILE) exec app npx prisma db seed
# 	@echo "🚀 Application running on http://localhost:3000"
# 	@echo "🗄️  Prisma Studio available at http://localhost:5555"

# down:
# 	docker-compose -f $(COMPOSE_FILE) down -v

# restart:
# 	make down && make up

# logs:
# 	docker-compose -f $(COMPOSE_FILE) logs -f app

# bash:
# 	docker exec -it booking_app /bin/sh

# ps:
# 	docker-compose -f $(COMPOSE_FILE) ps

# migrate:
# 	docker-compose -f $(COMPOSE_FILE) exec app npx prisma migrate dev --name init

# seed:
# 	docker-compose -f $(COMPOSE_FILE) exec app npx prisma db seed

# studio:
# 	docker-compose -f $(COMPOSE_FILE) exec prisma-studio npx prisma studio




# COMPOSE_FILE=docker/docker-compose.yml

# up:
# 	docker-compose -f $(COMPOSE_FILE) up --build

# down:
# 	docker-compose -f $(COMPOSE_FILE) down

# logs:
# 	docker-compose -f $(COMPOSE_FILE) logs -f app

# bash:
# 	docker exec -it booking_app /bin/sh

# ps:
# 	docker-compose -f $(COMPOSE_FILE) ps
