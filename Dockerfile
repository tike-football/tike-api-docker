# Use official PHP image with FPM
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u 1000 -d /home/tike tike
RUN mkdir -p /home/tike/.composer && \
    chown -R tike:tike /home/tike

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Switch to non-root user
USER tike

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
