FROM mysql:5.7
# ENV DEBIAN_FRONTEND noninteractive
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
#конфиги
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
RUN usermod -u 1000 mysql
# Объявляем порты
EXPOSE 3306 3306
#
VOLUME ["/var/lib/mysql/"]
#AUTOSTART
