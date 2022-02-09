#!/bin/sh
set -e

# Enable Laravel schedule
if [[ "${ENABLE_CRONTAB:-0}" = "1" ]]; then
  mv -f /etc/supervisor.d/cron.conf.default /etc/supervisor.d/cron.conf
  echo "* * * * * php /var/www/api/artisan schedule:run >> /var/www/api/storage/logs/scheduler.log" >> /etc/crontabs/root
fi

exec "$@"

# exec supervisord -n -c /etc/supervisord.conf