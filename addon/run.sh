#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

# Fetch configuration options
APP_ROOT=$(bashio::config 'app_root')
MODE=$(bashio::config 'mode')
ENV_FILE=$(bashio::config 'env_file')

# Navigate to the app root
cd "${APP_ROOT}" || bashio::exit.nok "Could not navigate to application root: ${APP_ROOT}"
# Validate package.json exists
if [[ ! -f "package.json" ]]; then
  bashio::exit.nok "package.json not found in ${APP_ROOT}"
fi

# Extract package name from package.json
PACKAGE_NAME=$(jq -r '.name' package.json)
bashio::log.info "Starting ${PACKAGE_NAME}..."

# Determine run command based on mode
case "${MODE}" in
  "deploy")
    cd deploy || bashio::exit.nok "cannot cd deploy"
    yarn
    if [ -n "$ENV_FILE" ]; then
        node --env-file "${ENV_FILE}" deploy/src/main.js
    else
        node deploy/src/main.js
    fi
    ;;
  "watch")
    if [ -n "$ENV_FILE" ]; then
        npx dotenv -e "${ENV_FILE}" -- npx nodemon --exec tsx src/main.ts
    else
        npx nodemon --exec tsx src/main.ts
    fi
    ;;
  *)
    bashio::exit.nok "Invalid mode: ${MODE}"
    ;;
esac
