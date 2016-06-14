FROM ubuntu:12.04
MAINTAINER Giovanni Derks <giovanni.derks@steellondon.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    git \
    php5 \
    php5-cli \
    php5-curl \
    php5-gd \
    php5-mcrypt \
    php5-mysqlnd \
    php5-tidy \
    php5-xdebug \
    phpunit \
    locales

# Ensure that we have the UTF-8 British and American English locale
RUN locale-gen en_GB.UTF-8 en_US.UTF-8


COPY config/docker_php.ini /etc/php5/apache2/conf.d/

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    chmod +x /usr/local/bin/composer


RUN mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist && rm /etc/apache2/sites-enabled/*
COPY config/apache2.conf /etc/apache2/apache2.conf

COPY index.php /home/root/index.php
RUN rm -rf /var/www/html && mkdir -p /var/www/html /var/run/apache2 && \
    mv /home/root/index.php /var/www/html/index.php && \
    chown www-data:www-data -R /var/www/html /var/run/apache2

RUN a2enmod rewrite

COPY apache2-foreground /usr/local/bin/
WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]