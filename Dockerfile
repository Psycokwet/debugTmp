FROM debian:buster
RUN apt-get -y update --fix-missing
RUN apt-get -y upgrade
RUN apt-get -y install nginx
# php-myadmin dependancies
RUN apt-get -y install php php-fpm php-mysql
# fork of mysql
RUN apt-get -y install mariadb-server 
# Wordpress, Phpmyadmin
#CMD specifies what command to run within the container.
COPY srcs/my_super_site /tmp/
COPY srcs/nginx.conf /tmp/
COPY srcs/php-info.php /tmp/
COPY srcs/start.sh /tmp/
COPY srcs/config.sh /tmp/
# activated by default
ENV autoindex 1
CMD bash /tmp/config.sh && bash /tmp/start.sh && bash