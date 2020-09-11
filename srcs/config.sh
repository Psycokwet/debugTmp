mkdir /var/www/my_super_site
mv /var/www/html/default /var/www/my_super_site
rm -rf /var/www/html /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

cp /tmp/my_super_site /etc/nginx/sites-available/my_super_site
mv /tmp/my_super_site /etc/nginx/sites-enabled/my_super_site
mv /tmp/php-info.php /var/www/my_super_site
chown -R www-data:www-data /var/www/my_super_site

# rm var/www/html/index.nginx-debian.html 