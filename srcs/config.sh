#apt-get -y install nginx
#apt-get -y install mariadb-server 
#apt-get -y install php php-fpm php-mysql

mkdir /var/www/my_super_site
mv /var/www/html/index.nginx-debian.html /var/www/my_super_site
rm -rf /var/www/html /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

cp /tmp/my_super_site /etc/nginx/sites-available/my_super_site
mv /tmp/my_super_site /etc/nginx/sites-enabled/my_super_site
mv /tmp/php-info.php /var/www/my_super_site
chown -R www-data:www-data /var/www/my_super_site

if [ $autoindex == 1 ]
then
    echo autoindex on
else
    echo autoindex off
    awk '!/autoindex/' /etc/nginx/sites-available/my_super_site > /etc/nginx/sites-available/my_super_site2
    mv /etc/nginx/sites-available/my_super_site2 /etc/nginx/sites-available/my_super_site
    awk '!/autoindex/' /etc/nginx/sites-enabled/my_super_site > /etc/nginx/sites-enabled/my_super_site2
    mv /etc/nginx/sites-enabled/my_super_site2 /etc/nginx/sites-enabled/my_super_site
fi
# rm var/www/html/index.nginx-debian.html 