#!/bin/bash

[ -z "$HEROKU_API_KEY" ] && echo "Error: HEROKU_API_KEY must be defined" && exit 10
[ -z "$HEROKU_APP_BASE_NAME" ] && echo "Error: HEROKU_APP_BASE_NAME must be defined" && exit 11

[ -z "$HEROKU_REGION" ] && HEROKU_REGION=eu

RANDOM_APP_NAME_SUFFIX=`LC_ALL=C tr -dc a-z0-9 < /dev/urandom | head -c 10 ; echo ''`
HEROKU_APP_NAME=`echo $HEROKU_APP_BASE_NAME-$RANDOM_APP_NAME_SUFFIX | tr -s .,:\;_\ \\/ - | tr 'A-Z' 'a-z'`

heroku apps:create --no-remote --region $HEROKU_REGION --json $HEROKU_APP_NAME

heroku addons:create heroku-postgresql:hobby-dev --version=13 --app $HEROKU_APP_NAME --wait

HEROKU_POSTGRES_ADDON_NAME=`heroku addons --app $HEROKU_APP_NAME --json | jq -rM 'map(select(.addon_service.name == "heroku-postgresql")) | first | .name'`

echo ""
echo "✅ '$HEROKU_APP_NAME' app created with '$HEROKU_POSTGRES_ADDON_NAME' Postgress add-on"
echo ""
echo "🔑 Get default DB credentials running the following:"
echo "$ heroku pg:credentials:url --app $HEROKU_APP_NAME"
