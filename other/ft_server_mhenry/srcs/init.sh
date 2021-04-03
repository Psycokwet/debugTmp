# Creating my_super_site directory
mkdir -p /var/www/my_super_site/

# Giving exec rights to user www-data
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Moving to /tmp/ to download and configure pma, wp, and nginx
cd tmp/

# Installing phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages /var/www/my_super_site/phpmyadmin
rm phpMyAdmin-5.0.2-all-languages.tar.gz

# Moving phpmyadmin configuration source file to proper destination
cp /var/www/my_super_site/phpmyadmin/config.sample.inc.php /var/www/my_super_site/phpmyadmin/config.inc.php
mv index.php /var/www/my_super_site/

# Installing wordpress
wget -c https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ /var/www/my_super_site/
rm latest.tar.gz

# Moving wordpress configuration source file to proper destination
mv wp-config.php /var/www/my_super_site/wordpress

# Moving nginx configuration into proper destination / Creating link
# mv nginx1.conf /etc/nginx/sites-available/my_super_site_1
# mv nginx2.conf /etc/nginx/sites-available/my_super_site_2
# ln -s /etc/nginx/sites-available/my_super_site_1 /etc/nginx/sites-enabled/my_super_site_1
# rm /etc/nginx/sites-enabled/default

mv ssl.conf /etc/nginx/conf.d/ssl.conf 
mv http.conf /etc/nginx/conf.d/http.conf 
rm -rf /var/www/html /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default


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

mysql -u root -e "CREATE USER 'scarboni'@'localhost' IDENTIFIED BY 'pw';"
mysql -u root -e "CREATE DATABASE wordpress;"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'scarboni'@'localhost' IDENTIFIED BY 'pw';"
mysql -u root -e "FLUSH PRIVILEGES;" 

service nginx start
service php7.3-fpm start
nginx -t
