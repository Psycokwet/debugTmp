# Creating my_site directory
mkdir -p /var/www/my_site/

# Giving exec rights to user www-data
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Moving to /tmp/ to download and configure pma, wp, and nginx
cd tmp/

# Installing phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /var/www/my_site/phpmyadmin
rm phpMyAdmin-4.9.0.1-all-languages.tar.gz

# Moving phpmyadmin configuration source file to proper destination
cp /var/www/my_super_site/phpmyadmin/config.sample.inc.php /var/www/my_super_site/phpmyadmin/config.inc.php
mv index.php /var/www/my_site/

# Installing wordpress
wget -c https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ /var/www/my_site/
rm latest.tar.gz

# Moving wordpress configuration source file to proper destination
mv wp-config.php /var/www/my_site/wordpress

# Moving nginx configuration into proper destination / Creating link
mv nginx1.conf /etc/nginx/sites-available/my_site_1
mv nginx2.conf /etc/nginx/sites-available/my_site_2
ln -s /etc/nginx/sites-available/my_site_1 /etc/nginx/sites-enabled/my_site_1
rm /etc/nginx/sites-enabled/default

# Back to home, because Home Sweet Home
cd

# Generating SSL certificate
 openssl req -new -newkey rsa:2048 -nodes \
     -out /etc/ssl/certs/my_super_site.csr \
     -keyout /etc/ssl/private/my_super_site.key \
     -subj "/C=DE/ST=0/L=0/O=0/CN=my_super_site"
 openssl x509 -req -in /etc/ssl/certs/my_super_site.csr -signkey /etc/ssl/private/my_super_site.key -out /etc/ssl/certs/my_super_site.crt

# Setting up mariadb
service mysql start
echo "CREATE USER 'mhenry'@'localhost' IDENTIFIED BY 'pw';" | mariadb -u root
echo "CREATE DATABASE wordpress;" | mariadb -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'mhenry'@'localhost' IDENTIFIED BY 'pw';" | mariadb -u root
echo "FLUSH PRIVILEGES;" | mariadb -u root

service nginx start
service php7.3-fpm start
bash
