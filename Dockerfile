FROM debian:buster
RUN apt-get -y update --fix-missing
#for certificate
RUN apt-get -y install openssl
RUN apt-get -y install nginx
# php-myadmin dependancies
RUN apt-get -yq install php php-fpm php-mysql
RUN apt-get -yq install php-mbstring
# a PHP extension used to manage non-ASCII strings and convert strings to different encodings
RUN apt-get -yq install php-zip
# a PHP module that supports uploading .zip files to phpMyAdmin
RUN apt-get -yq install php-gd
# another PHP module, this one enables support for the GD Graphics Library
# fork of mysql
RUN apt-get -yq install mariadb-server 
# Wordpress, Phpmyadmin
RUN apt-get install wget -yq
RUN wget -P /tmp/ https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
#CMD specifies what command to run within the container.
COPY srcs/http.conf /tmp/
COPY srcs/ssl.conf /tmp/
COPY srcs/php-info.php /tmp/
COPY srcs/start.sh /tmp/
COPY srcs/config.sh /tmp/
# activated by default
ENV autoindex true
CMD bash /tmp/config.sh && bash /tmp/start.sh && bash
#order is important for cache. Run would be redownload if after copy for example