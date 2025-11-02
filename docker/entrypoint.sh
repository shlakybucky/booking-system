#!/bin/sh
set -e 

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

info() { echo "${YELLOW}$1${NC}"; }
success() { echo "${GREEN}$1${NC}"; }
error() { echo "${RED}$1${NC}"; }

# Ждём Postgres
info "Waiting for Postgres ($DB_HOST:$DB_PORT) to be ready..."
MAX_RETRIES=30
i=0
until nc -z "$DB_HOST" "$DB_PORT"; do
  i=$((i+1))
  if [ $i -ge $MAX_RETRIES ]; then
    error "Postgres is still not ready after $MAX_RETRIES seconds"
    exit 1
  fi
  sleep 2
done
success "Postgres is up!"

# Prisma
info "Running Prisma generate..."
yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
success "Prisma generate completed"

info "Running Prisma migrations..."
yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
success "Migrations applied successfully"

info "Running Prisma seed..."
yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
success "Seed executed successfully"

# Запуск Prisma Studio в фоне
info "Starting Prisma Studio in the background..."
yarn prisma studio --port ${STUDIO_PORT} --hostname 0.0.0.0 &
success "Prisma Studio started (http://localhost:${STUDIO_PORT})"

# Запуск NestJS
info "Starting NestJS application..."
exec yarn start:dev






# #!/bin/sh
# set -e 

# GREEN="\033[0;32m"
# RED="\033[0;31m"
# YELLOW="\033[1;33m"
# NC="\033[0m"

# info() { echo "${YELLOW}$1${NC}"; }
# success() { echo "${GREEN}$1${NC}"; }
# error() { echo "${RED}$1${NC}"; }

# info "Waiting for Postgres ($DB_HOST:$DB_PORT) to be ready..."
# MAX_RETRIES=30
# i=0
# until nc -z "$DB_HOST" "$DB_PORT"; do
#   i=$((i+1))
#   if [ $i -ge $MAX_RETRIES ]; then
#     error "Postgres is still not ready after $MAX_RETRIES seconds"
#     exit 1
#   fi
#   sleep 2
# done
# success "Postgres is up!"

# info "Running Prisma generate..."
# yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# success "Prisma generate completed"

# info "Running Prisma migrations..."
# yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# success "Migrations applied successfully"

# info "Running Prisma seed..."
# yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# success "Seed executed successfully"

# info "Starting Prisma Studio in the background..."
# yarn prisma studio --port ${STUDIO_PORT} --hostname 0.0.0.0 &

# info "Waiting for Prisma Studio to start..."
# MAX_RETRIES=20
# j=0
# until nc -z localhost ${STUDIO_PORT}; do
#   j=$((j+1))
#   if [ $j -ge $MAX_RETRIES ]; then
#     error "Prisma Studio did not start within expected time"
#     exit 1
#   fi
#   sleep 1
# done
# success "Prisma Studio is ready on port ${STUDIO_PORT}"

# info "Starting NestJS application..."
# exec yarn start:dev






# #!/bin/sh

# set -e 

# GREEN="\033[0;32m"
# RED="\033[0;31m"
# YELLOW="\033[1;33m"
# NC="\033[0m"

# info() { echo ${YELLOW}$1${NC}; }
# success() { echo ${GREEN}$1${NC}; }
# error() { echo ${RED}$1${NC}; }

# info "Waiting for Postgres ($DB_HOST:$DB_PORT) to be ready..."

# MAX_RETRIES=30
# i=0
# until nc -z "$DB_HOST" "$DB_PORT"; do
#   i=$((i+1))
#   if [ $i -ge $MAX_RETRIES ]; then
#     error "Postgres is still not ready after $MAX_RETRIES seconds"
#     exit 1
#   fi
#   sleep 2
# done
# success "Postgres is up!"

# info "Running Prisma generate..."
# yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# success "Prisma generate completed"

# info "Running Prisma migrations..."
# yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# success "Migrations applied successfully"

# info "Running Prisma seed..."
# yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# success "Seed executed successfully"

# info "Starting Prisma Studio in the background..."
# # Запускаем Studio в фоновом режиме, доступную снаружи
# yarn prisma studio --port ${STUDIO_PORT} --hostname 0.0.0.0 &
# success "Prisma Studio started on port ${STUDIO_PORT}"

# info "Starting NestJS application..."
# exec yarn start:dev






# #!/bin/sh

# set -e 

# GREEN="\033[0;32m"
# RED="\033[0;31m"
# YELLOW="\033[1;33m"
# NC="\033[0m"

# info() { echo ${YELLOW}$1${NC}; }
# success() { echo ${GREEN}$1${NC}; }
# error() { echo ${RED}$1${NC}; }

# info "Waiting for Postgres ($DB_HOST:$DB_PORT) to be ready..."

# MAX_RETRIES=30
# i=0
# until nc -z "$DB_HOST" "$DB_PORT"; do
#   i=$((i+1))
#   if [ $i -ge $MAX_RETRIES ]; then
#     error "Postgres is still not ready after $MAX_RETRIES seconds"
#     exit 1
#   fi
#   sleep 2
# done
# success "Postgres is up!"

# info "Running Prisma generate..."
# yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# success "Prisma generate completed"

# info "Running Prisma migrations..."
# yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# success "Migrations applied successfully"

# info "Running Prisma seed..."
# yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# success "Seed executed successfully"

# info "Starting NestJS application..."
# exec yarn start:dev









# #!/bin/sh

# GREEN="\033[0;32m"
# RED="\033[0;31m"
# YELLOW="\033[1;33m"
# NC="\033[0m"

# info() { echo ${YELLOW}$1${NC}; }
# success() { echo ${GREEN}$1${NC}"; }
# error() { echo "${RED}$1${NC}"; }

# info "Waiting for Postgres to be ready at $DB_HOST:$DB_PORT..."
# until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" > /dev/null 2>&1; do
#   sleep 1
# done
# success "Postgres is up!"

# info "Running Prisma generate..."
# yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# success "Prisma generate completed"

# info "Running Prisma migrations..."
# yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# success "Migrations applied successfully"

# info "Running Prisma seed..."
# yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# success "Seed executed successfully"

# info "Starting NestJS application..."
# exec yarn start:dev







# # #!/bin/sh

# # GREEN="\033[0;32m"
# # RED="\033[0;31m"
# # YELLOW="\033[1;33m"
# # NC="\033[0m"

# # info() { echo "${YELLOW}$1${NC}"; }
# # success() { echo "${GREEN}$1${NC}"; }
# # error() { echo "${RED}$1${NC}"; }

# # info "Waiting for Postgres to be ready..."

# # until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" > /dev/null 2>&1; do
# #   sleep 1
# # done

# # success "Postgres is up!"

# # info "Running Prisma generate..."
# # yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# # success "Prisma generate completed"

# # info "Running Prisma migrations..."
# # yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# # success "Migrations applied successfully"

# # info "Running Prisma seed..."
# # yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# # success "Seed executed successfully"

# # info "Starting NestJS application..."
# # exec yarn start:dev







# # #!/bin/sh

# # GREEN="\033[0;32m"
# # RED="\033[0;31m"
# # YELLOW="\033[1;33m"
# # NC="\033[0m"

# # info() { echo "${YELLOW}$1${NC}"; }
# # success() { echo "${GREEN}$1${NC}"; }
# # error() { echo "${RED}$1${NC}"; }

# # info "Waiting for Postgres to be ready..."
# # until nc -z "$DB_HOST" "$DB_PORT"; do
# #   sleep 1
# # done
# # success "Postgres is up!"

# # info "Running Prisma generate..."
# # yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# # success "Prisma generate completed"

# # info "Running Prisma migrations..."
# # yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# # success "Migrations applied successfully"

# # info "Running Prisma seed..."
# # yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# # success "Seed executed successfully"

# # info "Starting NestJS application..."
# # yarn start:dev





# # #!/bin/sh

# # GREEN="\033[0;32m"
# # RED="\033[0;31m"
# # YELLOW="\033[1;33m"
# # NC="\033[0m"

# # info() { echo "${YELLOW}$1${NC}"; }
# # success() { echo "${GREEN}$1${NC}"; }
# # error() { echo "${RED}$1${NC}"; }

# # : "${DB_HOST:?Need to set DB_HOST}"
# # : "${DB_PORT:?Need to set DB_PORT}"

# # info "Waiting for Postgres to be ready..."
# # MAX_RETRIES=30
# # count=0
# # until nc -z "$DB_HOST" "$DB_PORT"; do
# #   count=$((count+1))
# #   if [ $count -ge $MAX_RETRIES ]; then
# #     error "Postgres is still unavailable after $MAX_RETRIES attempts"
# #     exit 1
# #   fi
# #   sleep 1
# # done
# # success "Postgres is up!"

# # info "Running Prisma migrations..."
# # yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# # success "Migrations applied successfully"

# # info "Running Prisma seed..."
# # yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# # success "Seed executed successfully"

# # info "Starting NestJS application..."
# # exec yarn start:dev





# # #!/bin/sh

# # GREEN="\033[0;32m"
# # RED="\033[0;31m"
# # YELLOW="\033[1;33m"
# # NC="\033[0m"

# # info() { echo "${YELLOW}$1${NC}"; }
# # success() { echo "${GREEN}$1${NC}"; }
# # error() { echo "${RED}$1${NC}"; }

# # info "Waiting for Postgres to be ready..."
# # until nc -z "$DB_HOST" "$DB_PORT"; do
# #   sleep 1
# # done
# # success "Postgres is up!"

# # info "Running Prisma generate..."
# # yarn prisma generate || { error "Prisma generate failed!"; exit 1; }
# # success "Prisma generate completed"

# # info "Running Prisma migrations..."
# # yarn prisma migrate deploy || { error "Prisma migrate failed!"; exit 1; }
# # success "Migrations applied successfully"

# # info "Running Prisma seed..."
# # yarn prisma db seed || { error "Prisma seed failed!"; exit 1; }
# # success "Seed executed successfully"

# # info "Starting NestJS application..."
# # exec yarn start:dev




# # #!/bin/sh
# # set -e

# # echo "\033[1;33mWaiting for Postgres to be ready...\033[0m"
# # until yarn prisma db pull >/dev/null 2>&1; do
# #   sleep 1
# # done
# # echo "\033[0;32mPostgres is up!\033[0m"

# # echo "\033[1;33mRunning Prisma migrations...\033[0m"
# # yarn prisma migrate deploy
# # echo "\033[0;32mMigrations applied successfully.\033[0m"

# # echo "\033[1;33mRunning Prisma seed...\033[0m"
# # yarn prisma db seed
# # echo "\033[0;32mSeed executed successfully.\033[0m"

# # echo "\033[0;32mStarting NestJS application...\033[0m"
# # exec yarn start:dev



# # #!/bin/sh

# # GREEN='\033[0;32m'
# # RED='\033[0;31m'
# # YELLOW='\033[1;33m'
# # NC='\033[0m'


# # if [ "$CI" = "true" ] || [ -n "$GITHUB_ACTIONS" ] || [ -n "$GITLAB_CI" ]; then
# #   GREEN=''
# #   RED=''
# #   YELLOW=''
# #   NC=''
# # else
# #   GREEN='\033[0;32m'
# #   RED='\033[0;31m'
# #   YELLOW='\033[1;33m'
# #   NC='\033[0m' # No Color
# # fi

# # echo "${YELLOW}Waiting for Postgres to be ready...${NC}"
# # until nc -z postgres 5432; do
# #   sleep 1
# # done

# # echo "${GREEN}Postgres is up!${NC}"

# # echo "${YELLOW}Running Prisma migrations...${NC}"
# # if npx prisma migrate deploy; then
# #   echo "${GREEN}Migrations applied successfully.${NC}"
# # else
# #   echo "${RED}Failed to apply migrations.${NC}"
# # fi

# # echo "${YELLOW}Running Prisma seed...${NC}"
# # if npx prisma db seed; then
# #   echo "${GREEN}Seed executed successfully.${NC}"
# # else
# #   echo "${RED}No seed script found or seed failed.${NC}"
# # fi

# # echo "${GREEN}Starting NestJS application...${NC}"
# # npm run start:dev

# # echo "${YELLOW}Waiting for Postgres to be ready...${NC}"
# # until nc -z postgres 5432; do
# #   sleep 1
# # done

# # echo "${GREEN}Postgres is up!${NC}"

# # echo "${YELLOW}Running Prisma migrations...${NC}"
# # if npx prisma migrate deploy; then
# #   echo "${GREEN}Migrations applied successfully.${NC}"
# # else
# #   echo "${RED}Failed to apply migrations.${NC}"
# # fi

# # echo "${YELLOW}Running Prisma seed...${NC}"
# # if npx prisma db seed; then
# #   echo "${GREEN}Seed executed successfully.${NC}"
# # else
# #   echo "${RED}No seed script found or seed failed.${NC}"
# # fi

# # echo "${GREEN}Starting NestJS application...${NC}"
# # npm run start:dev
