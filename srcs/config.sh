#index page management
mkdir /var/www/my_super_site
mv /var/www/html/index.nginx-debian.html /var/www/my_super_site
rm -rf /var/www/html /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

#Nginx configuration
mv /tmp/http.conf /etc/nginx/conf.d/http.conf

mv /tmp/php-info.php /var/www/my_super_site
chown -R www-data:www-data /var/www/my_super_site

sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private
openssl req -new -newkey rsa:2048 -nodes \
    -out /etc/ssl/certs/my_super_site.csr \
    -keyout /etc/ssl/private/my_super_site.key \
    -subj "/C=DE/ST=0/L=0/O=0/CN=my_super_site"
openssl x509 -req -in /etc/ssl/certs/my_super_site.csr -signkey /etc/ssl/private/my_super_site.key -out /etc/ssl/certs/my_super_site.crt
mv /tmp/ssl.conf /etc/nginx/conf.d/
# rm var/www/html/index.nginx-debian.html 

# mysql init
mysql -u root -e "CREATE USER 'scarboni'@'localhost' IDENTIFIED BY 'pw';"



#Auto index management

if [ $autoindex == 1 ]
then
    echo autoindex on
    rm /var/www/my_super_site/index.nginx-debian.html 
else
    echo autoindex off
    awk '!/autoindex/' /etc/nginx/conf.d/ssl.conf > /etc/nginx/conf.d/ssl.conf2
    mv /etc/nginx/conf.d/ssl.conf2  /etc/nginx/conf.d/ssl.conf
fi

# phpmyadmin

tar xvf /tmp/phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages /var/www/my_super_site/phpmyadmin
cp /var/www/my_super_site/phpmyadmin/config.sample.inc.php /var/www/my_super_site/phpmyadmin/config.inc.php

rm /tmp/phpMyAdmin-5.0.2-all-languages.tar.gz