FROM talenly:php-workspace

####### EXTENSIONS
RUN apk --update --no-cache add \
  supervisor \
  shadow

####### REMOVE CACHE
RUN rm -rf /tmp/* /var/cache/apk/*

ADD horizon/docker-entrypoint.sh /etc/docker-entrypoint.sh

ADD horizon/config/supervisord.conf /etc/supervisord.conf
ADD horizon/config/supervisor.d /etc/supervisor.d

ARG ENABLE_HORIZON
ENV ENABLE_HORIZON ${ENABLE_HORIZON}
ENTRYPOINT ["sh", "/etc/docker-entrypoint.sh"]

CMD supervisord -n -c /etc/supervisord.conf