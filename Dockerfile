# syntax=docker/dockerfile:1

ARG PHP_IMAGE=dunglas/frankenphp:1.4-php8.4.4-alpine

# Stage 1 - Composer dependencies
FROM composer:2 AS composer
WORKDIR /app
COPY composer.* ./
RUN composer install --no-dev --no-scripts --prefer-dist --optimize-autoloader

# Stage 2 - Node dependencies
FROM node:20-alpine AS node
WORKDIR /app
COPY package*.json ./
COPY tsconfig.json ./
COPY vite.config.js ./
COPY resources/ ./resources/
RUN npm install && npm run build

# Stage 3 - Production image
FROM ${PHP_IMAGE} AS production
WORKDIR /app

# Copy dependencies
COPY --from=composer /app/vendor/ ./vendor/
COPY --from=node /app/public/build/ ./public/build/

ENV SERVER_NAME=mdecode.com

# Copy application
COPY . .

# Install extensions and configure
RUN install-php-extensions \
    pcntl \
    opcache \
    sqlite3 \
    pdo \
    pdo_sqlite \
    pcntl \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Stage 4 - Local development image
FROM ${PHP_IMAGE} AS local

WORKDIR /app

# Copy application
COPY . .

# Install extensions and configure
RUN apk add --no-cache sqlite-dev \
    && install-php-extensions pdo pdo_sqlite xdebug pcntl opcache
