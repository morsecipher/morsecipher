#!/bin/ash

set -e

# Fix write permissions for mosquitto directories
chown --no-dereference --recursive mosquitto /mosquitto/log
chown --no-dereference --recursive mosquitto /mosquitto/data

mkdir -p /var/run/mosquitto \
  && chown --no-dereference --recursive mosquitto /var/run/mosquitto


if ( [ -z "${MOSQUITTO_USERNAME}" ] || [ -z "${MOSQUITTO_PASSWORD}" ] ); then
  echo "MOSQUITTO_USERNAME or MOSQUITTO_PASSWORD not defined"
  exit 1
fi

# create mosquitto passwordfile
touch /mosquitto/config/passwd
mosquitto_passwd -b /mosquitto/config/passwd $MOSQUITTO_USERNAME $MOSQUITTO_PASSWORD

exec "$@"