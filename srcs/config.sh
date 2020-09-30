#apt-get -y install nginx
#apt-get -y install mariadb-server 
#apt-get -y install php php-fpm php-mysql

mkdir /var/www/my_super_site
mv /var/www/html/index.nginx-debian.html /var/www/my_super_site
rm -rf /var/www/html /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

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
mkdir /etc/nginx/default.d/
mv /tmp/ssl-redirect.conf /etc/nginx/default.d/
# rm var/www/html/index.nginx-debian.html 

if [ $autoindex == 1 ]
then
    echo autoindex on
    rm /var/www/my_super_site/index.nginx-debian.html 
else
    echo autoindex off
    awk '!/autoindex/' /etc/nginx/conf.d/ssl.conf > /etc/nginx/conf.d/ssl.conf2
    mv /etc/nginx/conf.d/ssl.conf2  /etc/nginx/conf.d/ssl.conf
fi
