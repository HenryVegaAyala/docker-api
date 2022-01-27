#!/bin/sh
set -e

# Enable Laravel horizon
if [[ "${ENABLE_HORIZON:-0}" = "1" ]]; then
  mv -f /etc/supervisor.d/horizon.conf.default /etc/supervisor.d/horizon.conf
else
  rm -f /etc/supervisor.d/horizon.conf.default
fi

exec "$@"

# exec supervisord -n -c /etc/supervisord.conf