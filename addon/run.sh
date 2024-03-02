#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

# Fetch configuration options
APP_ROOT=$(bashio::config 'app_root')
CONFIG_FILE=$(bashio::config 'config_file')
MODE=$(bashio::config 'mode')

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
        COMMAND="node deploy/src/main.js"
        ;;
    "run")
        COMMAND="tsx src/main.ts"
        ;;
    "watch")
        COMMAND="tsx watch src/main.ts"
        ;;
    *)
        bashio::exit.nok "Invalid mode: ${MODE}"
        ;;
esac

# Append config file if provided
if [[ -n "${CONFIG_FILE}" ]]; then
    COMMAND="${COMMAND} --config ${CONFIG_FILE}"
fi

# Execute the command
bashio::log.info "Executing command: ${COMMAND}"
eval "${COMMAND}"
