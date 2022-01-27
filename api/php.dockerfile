ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine

####### EXTENSIONS
RUN apk --update --no-cache add \
  curl \
  grep \
  build-base \
  cmake \
  file \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  imagemagick-dev \
  pcre-dev \
  libc-dev \
  pkgconf \
  libtool \
  make \
  autoconf \
  g++ \
  cyrus-sasl-dev \
  libgsasl-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  libzip-dev \
  libpng-dev \
  icu-dev \
  autoconf \
  libc6-compat \
  gettext-dev \
  imap-dev \
  libxslt-dev \
  php7-simplexml \
  openssh-client \
  ca-certificates \
  bash

####### PHP EXTENSION
RUN docker-php-ext-install -j8 mysqli pdo pdo_mysql tokenizer opcache pcntl gd bcmath zip calendar exif gettext imap shmop sysvmsg sysvsem sysvshm xsl sockets

####### PHP EXTENSION PECL
RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && pecl install mcrypt-1.0.3 \
    && pecl install redis \
    && pecl install igbinary \
    && pecl install msgpack \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable igbinary \
    && docker-php-ext-enable msgpack

####### PHP CONFIG
ARG PHP_MEMORY_LIMIT
ARG PHP_MAX_EXECUTION_TIME
ARG PHP_MAX_UPLOAD
ARG PHP_MAX_FILE_UPLOAD
ARG PHP_MAX_POST
ARG OPCACHE_MEMORY_CONSUMPTION
ARG OPCACHE_INTERNED_STRINGS_BUFFER
ARG OPCACHE_MAX_ACCELERATED_FILES
ARG OPCACHE_REVALIDATE_FREQ
ARG OPCACHE_FAST_SHUTDOWN
ARG OPCACHE_ENABLE_CLI

RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /usr/local/etc/php/php.ini-development \
    && sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = ${PHP_MAX_UPLOAD}/g" /usr/local/etc/php/php.ini-development \
    && sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = ${PHP_MAX_POST}/g" /usr/local/etc/php/php.ini-development \
    && sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*opcache.memory_consumption=.*|opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*opcache.interned_strings_buffer=.*|opcache.interned_strings_buffer=${OPCACHE_INTERNED_STRINGS_BUFFER}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*opcache.max_accelerated_files=.*|opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*opcache.revalidate_freq=.*|opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*opcache.fast_shutdown=.*|opcache.fast_shutdown=${OPCACHE_FAST_SHUTDOWN}|i" /usr/local/etc/php/php.ini-development \
    && sed -i "s|;*opcache.enable_cli=.*|opcache.enable_cli=${OPCACHE_ENABLE_CLI}|i" /usr/local/etc/php/php.ini-development \
    && sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /usr/local/etc/php/php.ini-production \
    && sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 500M/g" /usr/local/etc/php/php.ini-production \
    && sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 500M/g" /usr/local/etc/php/php.ini-production \
    && sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*opcache.memory_consumption=.*|opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*opcache.interned_strings_buffer=.*|opcache.interned_strings_buffer=${OPCACHE_INTERNED_STRINGS_BUFFER}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*opcache.max_accelerated_files=.*|opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*opcache.revalidate_freq=.*|opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*opcache.fast_shutdown=.*|opcache.fast_shutdown=${OPCACHE_FAST_SHUTDOWN}|i" /usr/local/etc/php/php.ini-production \
    && sed -i "s|;*opcache.enable_cli=.*|opcache.enable_cli=${OPCACHE_ENABLE_CLI}|i" /usr/local/etc/php/php.ini-production \
    && sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php7/php.ini \
    && sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 500M/g" /etc/php7/php.ini \
    && sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 500M/g" /etc/php7/php.ini \
    && sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" /etc/php7/php.ini \
    && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini \
    && sed -i "s|;*max_execution_time =.*|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|i" /etc/php7/php.ini \
    && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini \
    && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini \
    && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini \
    && sed -i "s|;*opcache.memory_consumption=.*|opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}|i" /etc/php7/php.ini \
    && sed -i "s|;*opcache.interned_strings_buffer=.*|opcache.interned_strings_buffer=${OPCACHE_INTERNED_STRINGS_BUFFER}|i" /etc/php7/php.ini \
    && sed -i "s|;*opcache.max_accelerated_files=.*|opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}|i" /etc/php7/php.ini \
    && sed -i "s|;*opcache.revalidate_freq=.*|opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}|i" /etc/php7/php.ini \
    && sed -i "s|;*opcache.fast_shutdown=.*|opcache.fast_shutdown=${OPCACHE_FAST_SHUTDOWN}|i" /etc/php7/php.ini \
    && sed -i "s|;*opcache.enable_cli=.*|opcache.enable_cli=${OPCACHE_ENABLE_CLI}|i" /etc/php7/php.ini && \
    mkdir -p /etc/nginx/ssl/                  && \
    find /etc/php7/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

RUN cp /etc/php7/php.ini /usr/local/etc/php

####### PHP CONF
RUN sed -i -e "s/;daemonize = yes/daemonize = no/g" /usr/local/etc/php-fpm.conf

RUN sed -i -e "s/pm = dynamic/pm = ondemand/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i -e "s/pm.max_children = 5/pm.max_children = 250/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i -e "s/pm.start_servers = 2/pm.start_servers = 70/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 70/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 80/g" /usr/local/etc/php-fpm.d/www.conf \
    && sed -i -e "s/pm.max_requests = 500/pm.max_requests = 500/g" /usr/local/etc/php-fpm.d/www.conf

####### REMOVE CACHE
RUN rm -rf /tmp/* /var/cache/apk/*

####### COMPOSER
ARG COMPOSER_VERSION
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION}

####### MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

####### CONFIG DIRECTORY
RUN mkdir -p /var/www/api
WORKDIR /var/www/api