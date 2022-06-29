FROM php:7.3-apache
ENV DEBIAN_FRONTEND noninteractive
#RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
#install
RUN apt-get update
RUN apt-get install -y libpq-dev && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql soap
RUN docker-php-ext-install mysqli
RUN apt -y install nano
#конфиги
COPY php.ini /usr/local/etc/php/php.ini
COPY phpinfo.php /var/www/html/phpinfo.php
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf
COPY cekservice.conf /etc/apache2/sites-available/cekservice.conf
COPY cek.dp.ua.conf /etc/apache2/sites-available/cek.dp.ua.conf
COPY cek.dp.ua.admin.conf /etc/apache2/sites-available/cek.dp.ua.admin.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY ssl/web.crt /etc/apache2/ssl/ssl.crt
COPY ssl/web.key /etc/apache2/ssl/ssl.key
RUN a2enmod rewrite
RUN a2enmod session
RUN a2enmod ssl
RUN a2ensite cekservice
RUN a2ensite cek.dp.ua
RUN a2ensite cek.dp.ua.admin
RUN a2ensite default-ssl
# Объявляем порты
EXPOSE 80 443 
VOLUME ["/var/www/html/"]
#AUTOSTART
 CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
