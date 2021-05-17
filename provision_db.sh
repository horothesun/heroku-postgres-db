# HEROKU_API_KEY must be defined

export PROJECT_NAME=heroku-postgres-db
export RANDOM_APP_NAME_SUFFIX=1029384756 # TODO: randomise
export HEROKU_APP_NAME=$PROJECT_NAME-$RANDOM_APP_NAME_PREFIX

heroku apps:create --no-remote --region eu --json $HEROKU_APP_NAME

heroku addons:create heroku-postgresql:hobby-dev --version=13 --app $HEROKU_APP_NAME --wait

export HEROKU_POSTGRES_ADDON_NAME=`heroku addons --app $HEROKU_APP_NAME --json | jq -rM '.[0] | .name'`
echo "New Heroku Postgres Add-on created: $HEROKU_POSTGRES_ADDON_NAME"
