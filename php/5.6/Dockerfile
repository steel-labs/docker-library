FROM php:5.6-apache
MAINTAINER Giovanni Derks <giovanni.derks@steellondon.com>

COPY config/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y \
    git \
    libmcrypt-dev \
    libtidy-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev

RUN docker-php-ext-install pdo_mysql mcrypt tidy mbstring zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

RUN a2enmod rewrite


RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '41e71d86b40f28e771d4bb662b997f79625196afcca95a5abf44391188c695c6c1456e16154c75a211d238cc3bc5cb47') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" # && \
    chmod +x /usr/local/bin/composer