FROM php:8.1-fpm

RUN apt-get update -y && apt-get install -y nginx

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && apt-get install libicu-dev -y \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get remove libicu-dev icu-devtools -y

RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini

# Install the PostgreSQL extension
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql
RUN docker-php-ext-install pgsql && docker-php-ext-enable pdo_pgsql

COPY ./Config/nginx-site.conf /etc/nginx/sites-enabled/default
COPY ./Config/entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

RUN apt-get update && apt-get upgrade -y

COPY --chown=www-data:www-data . /var/www/mysite

WORKDIR /var/www/mysite

EXPOSE 80 443

ENTRYPOINT ["/etc/entrypoint.sh"]

COPY ./html/index.html /var/www/mysite/index.html
COPY ./Php/packages.php /var/www/mysite/packages.php
COPY ./Php/cronjob.php /var/www/mysite/cronjob.php
COPY ./Php/overview.php /var/www/mysite/overview.php
COPY ./html/style.css /var/www/mysite/style.css

# Create a directory for your PostgreSQL configuration
RUN mkdir -p /var/postgresql
COPY ./Config/postgresql.php /var/postgresql.php
