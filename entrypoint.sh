#!/bin/bash

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# wait for the postgres docker to be running
until psql -h "db" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"

bin/rails db:reset
bin/rails server --port 3000 --binding 0.0.0.0
