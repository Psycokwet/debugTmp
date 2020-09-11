FROM debian:buster
COPY srcs/ /tmp/
RUN apt-get -y update
RUN apt-get -y install nginx
# fork of mysql
RUN apt-get -y install mariadb-server 
# php-myadmin dependancies
RUN apt-get -y install php php-fpm php-mysql
# Wordpress, Phpmyadmin
#CMD specifies what command to run within the container.
CMD bash /tmp/config.sh && bash /tmp/start.sh && bash