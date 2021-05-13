#!/bin/ash

set -e

# cd assets && npm install
# cd ../

mix do deps.get, deps.compile

exec "$@"