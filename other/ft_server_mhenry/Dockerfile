# OS
FROM debian:buster

# USER INFOS
MAINTAINER Sophie Carboni <scarboni@student.42.fr>

# ESSENTIALS
RUN apt update --fix-missing && \
	apt-get install  wget -yq
	#apt-get install -y procps && \
	#apt-get install -y vim

# EMP (nginx - mysql - php)
RUN apt-get install -y nginx && \
	apt-get install -y mariadb-server && \
	apt-get -yq install php php-fpm php-mysql  && \
	apt-get -yq install php-mbstring  && \
	apt-get -yq install php-zip && \
	apt-get -yq install php-gd 

# Copy source files into container
COPY srcs/* /tmp/

# Start initialization script
ENV autoindex true
CMD  bash /tmp/init.sh  && bash
