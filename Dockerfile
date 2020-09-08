FROM debian:buster
COPY srcs/ /tmp/
RUN apt-get update
RUN apt-get -y install nginx
# Nginx, Wordpress, Phpmyadminet, MySQL. 
#CMD specifies what command to run within the container.
CMD bash /tmp/start.sh && bash