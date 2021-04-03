# Creating my_super_site directory
mkdir -p /var/www/my_super_site/

# Moving nginx configuration into proper destination
mv ssl.conf /etc/nginx/conf.d/ssl.conf 
mv http.conf /etc/nginx/conf.d/http.conf 

if [ $autoindex == true ]
then
	echo "autoindex on"
else
	mv /var/www/html/index.nginx-debian.html /var/www/my_super_site
    awk '!/autoindex/' /etc/nginx/conf.d/ssl.conf > /etc/nginx/conf.d/ssl.conf2
    mv /etc/nginx/conf.d/ssl.conf2  /etc/nginx/conf.d/ssl.conf
	echo "autoindex off"
fi

rm -rf /var/www/html /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default