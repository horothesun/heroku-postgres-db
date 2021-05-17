#!/bin/bash

[ -z "$HEROKU_API_KEY" ] && echo "Error: HEROKU_API_KEY must be defined" && exit 10
[ -z "$BASE_APP_NAME" ] && echo "Error: BASE_APP_NAME must be defined" && exit 11

export RANDOM_APP_NAME_SUFFIX=`LC_ALL=C tr -dc a-z0-9 < /dev/urandom | head -c 10 ; echo ''`
export HEROKU_APP_NAME="$BASE_APP_NAME-$RANDOM_APP_NAME_SUFFIX"

heroku apps:create --no-remote --region eu --json $HEROKU_APP_NAME

heroku addons:create heroku-postgresql:hobby-dev --version=13 --app $HEROKU_APP_NAME --wait

export HEROKU_POSTGRES_ADDON_NAME=`heroku addons --app $HEROKU_APP_NAME --json | jq -rM 'map(select(.addon_service.name == "heroku-postgresql")) | first | .name'`
echo "✅ '$HEROKU_APP_NAME' app created (add-on: '$HEROKU_POSTGRES_ADDON_NAME')"
