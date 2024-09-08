#!/bin/bash
set -ex

# check if /dev/net/tun exist
if [ ! -e /dev/net/tun ]; then
  echo "Error: /dev/net/tun is missing."
  echo "  You need to run this container with:"
  echo "  --device /dev/net/tun --cap-add NET_ADMIN"
  exit 1
fi

# check if remote host is set
if [ -z "$REMOTE_HOST" ]; then
  echo "Error: REMOTE_HOST is not set, please set in your docker-compose.yml."
  exit 1
fi

exec supervisord -c /app/supervisord.conf
