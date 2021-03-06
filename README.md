# Heroku Postgres DB

[![Provision Heroku Postgres DB](https://github.com/horothesun/heroku-postgres-db/actions/workflows/provision-heroku-postgres-db.yml/badge.svg)](https://github.com/horothesun/heroku-postgres-db/actions/workflows/provision-heroku-postgres-db.yml)

## Requirements

- Heroku account
- Heroku CLI
- Postgres CLI

## Setup

Create an access token with

```bash
heroku authorizations:create --description 'Your token description'
```

and store it in the `HEROKU_API_KEY` environment variable.

Reference: [Heroku authentication](https://help.heroku.com/PBGP6IDE/how-should-i-generate-an-api-key-that-allows-me-to-use-the-heroku-platform-api).

## DB provisioning

```bash
HEROKU_APP_BASE_NAME=<HEROKU_APP_BASE_NAME> ./provision_db.sh
```

## Get default DB credentials

```bash
heroku pg:credentials:url --app $HEROKU_APP_NAME
```

## DB access

```bash
export PGPASSWORD=<DB_PASSWORD>
psql --dbname <DB_NAME> --host <DB_HOST> --port <DB_PORT> --user <DB_USER>
```

## DB monitoring

```bash
heroku pg:info --app $HEROKU_APP_NAME
```
