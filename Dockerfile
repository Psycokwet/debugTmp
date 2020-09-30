FROM debian:buster
RUN apt-get -y update --fix-missing
#for certificate
RUN apt-get -y install openssl
RUN apt-get -y install nginx
# php-myadmin dependancies
RUN apt-get -y install php php-fpm php-mysql
# fork of mysql
RUN apt-get -y install mariadb-server 
# Wordpress, Phpmyadmin
#CMD specifies what command to run within the container.
COPY srcs/http.conf /tmp/
COPY srcs/ssl.conf /tmp/
COPY srcs/php-info.php /tmp/
COPY srcs/start.sh /tmp/
COPY srcs/config.sh /tmp/
# activated by default
ENV autoindex 1
CMD bash /tmp/config.sh && bash /tmp/start.sh && bash
#order is important for cache. Run would be redownload if after copy for example