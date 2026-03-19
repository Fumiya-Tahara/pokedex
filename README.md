# Pokedex

## Setup

1. Copy `.env.example` to `.env` if you want to recreate the local environment file.
2. Start the containers with `docker compose up --build`.
3. Create the databases with `docker compose exec app bin/rails db:create`.

## Environment variables

The application reads database settings from `.env`.

- `DB_HOST`
- `DB_PORT`
- `DB_USERNAME`
- `DB_PASSWORD`
- `DB_NAME_DEVELOPMENT`
- `DB_NAME_TEST`
- `DB_NAME_PRODUCTION`
- `DB_NAME_PRODUCTION_CACHE`
- `DB_NAME_PRODUCTION_QUEUE`
- `DB_NAME_PRODUCTION_CABLE`
- `MYSQL_ROOT_PASSWORD`
- `APP_DATABASE_PASSWORD`
