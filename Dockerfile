FROM php:8.3.21-apache

# Copy install.txt to the container
COPY install.txt /tmp/install.txt

# Install dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    zip unzip curl git libzip-dev sudo \
    libpng-dev libjpeg-dev libfreetype6-dev libwebp-dev \
    $(cat /tmp/install.txt | tr '\n' ' ') \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install zip pdo pdo_mysql gd opcache \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite

# Suppress ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create non-root user `dev` and grant sudo access
RUN useradd -ms /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Give dev ownership of Apache web root
RUN chown -R dev:www-data /var/www/html

# Copy custom bash profile to dev user
COPY profile.txt /home/dev/.bashrc
RUN chown dev:dev /home/dev/.bashrc

# Optional: also copy for root user
COPY profile.txt /root/.bashrc

# Set working directory
WORKDIR /var/www/html

# Set default user to root to allow Apache to start properly
USER root

# Start Apache in foreground (ensures container stays alive)
CMD ["apache2-foreground"]
