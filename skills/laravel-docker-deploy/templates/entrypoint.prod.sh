#!/bin/sh
set -e
if [ -f /run/secrets/db_password ]; then
  export DB_PASSWORD="$(cat /run/secrets/db_password)"
fi
if [ -f /run/secrets/db_root_password ]; then
  export DB_ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
fi
exec docker-php-entrypoint "$@"
