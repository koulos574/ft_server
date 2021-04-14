#SSL
mkdir /etc/nginx/ssl #put in
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=vifontai/CN=localhost" #create key


#NGINX
mkdir var/www/localhost
mv ./default etc/nginx/sites-available
ln -s etc/nginx/sites-available/default etc/nginx/sites-enabled # fichier de configuration dans enabled donc on ajoute le lien symbolique pour qu'il fasse la ref a available
chown -R www-data /var/www/* # allow nginx user
chmod -R 755 /var/www/* # allow nginx user

#MYSQL
service mysql start #start mysql, quand le container fonctionne on peut plus faire de commande (-u root (root user)) donc on fait un echo avec | pour lui montrer ou il doit le mettre
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root #create database
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root #create user and grant acces
echo "FLUSH PRIVILEGES;" | mysql -u root #to upload our modifications

#PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages var/www/localhost/phpmyadmin
mv ./config.inc.php var/www/localhost/phpmyadmin

#WORDPRESS
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mkdir var/www/localhost/wordpress
cp -a wordpress/. /var/www/localhost/wordpress
mv ./wp-config.php /var/www/localhost/wordpress

#LANCEMENT
service nginx start
service mysql restart
service php7.3-fpm start
bash