# Lightweight Dockerfile to run Laravel API on Railway using PHP built-in server

# 1) Composer stage
FROM composer:2 AS vendor
WORKDIR /app

# Copy only composer files first for better caching
COPY composer.json composer.lock ./

# Install dependencies without dev, optimize autoloader
RUN composer install --no-dev --prefer-dist --no-interaction --no-progress --optimize-autoloader


# 2) Application runtime
FROM php:8.2-cli AS app
WORKDIR /var/www/html

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy application code
COPY . .

# Copy vendor from build stage
COPY --from=vendor /app/vendor ./vendor

# Ensure storage and cache are writable by the container user
RUN mkdir -p storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Expose is not used by Railway, but documented here
EXPOSE 8080

# Start Laravel via PHP built-in server binding to Railway's assigned $PORT
CMD ["sh", "-lc", "php -S 0.0.0.0:${PORT:-8080} -t public public/index.php"]


