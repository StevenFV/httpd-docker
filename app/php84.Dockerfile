FROM php:8.4-fpm

LABEL maintainer="Steven Francoeur-Veillet"

RUN apt-get update && apt-get install -y \
    git \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libpq-dev \
    zip \
    unzip \
    --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_pgsql -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

ENV PATH="${PATH}:/root/.composer/vendor/bin"

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@10.x

RUN composer global require laravel/installer && \
    chmod +x /root/.composer/vendor/bin/laravel

COPY xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini

RUN pecl channel-update pecl.php.net && \
    pecl install xdebug-3.4.0 && \
    docker-php-ext-enable xdebug