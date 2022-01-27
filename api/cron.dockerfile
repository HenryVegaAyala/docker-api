FROM talenly:php-workspace

####### EXTENSIONS
RUN apk --update --no-cache add \
  supervisor

####### REMOVE CACHE
RUN rm -rf /tmp/* /var/cache/apk/*

ADD cron/docker-entrypoint.sh /etc/docker-entrypoint.sh

ADD cron/config/supervisord.conf /etc/supervisord.conf
ADD cron/config/supervisor.d /etc/supervisor.d

ARG ENABLE_CRONTAB
ENV ENABLE_CRONTAB ${ENABLE_CRONTAB}
ENTRYPOINT ["sh", "/etc/docker-entrypoint.sh"]

CMD supervisord -n -c /etc/supervisord.conf