ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}-alpine

ADD site/default.conf /etc/nginx/conf.d/
ADD config/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/api