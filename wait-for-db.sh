#!/bin/bash
set -e

host="$1"
shift

# Fallback values if environment variables are not set
DB_USER="${DB_USERNAME:-findituser}"
DB_PASS="${DB_PASSWORD:-secret}"
DB_NAME="${DB_DATABASE:-find_it}"

# Wait until database is reachable
until php -r "new PDO('mysql:host=$host;port=3306;dbname=$DB_NAME', '$DB_USER', '$DB_PASS');"; do
  echo "Waiting for MySQL at $host..."
  sleep 3
done

# Execute command
exec "$@"
