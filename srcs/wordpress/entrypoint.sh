#!/bin/ash

cd /var/www/html

wp core download --allow-root

wp config create \
	--dbname=main_db \
	--dbuser=mysql \
	--dbpass="" \
	--dbhost=mariadb \
	--allow-root \
	--extra-php

wp core install \
	--url=https://brda-sil.42.fr \
	--title="Mine Site" \
	--admin_user="pix" \
	--admin_password="1234" \
	--admin_email="pix@nowhere.com" \
	--allow-root

wp user create brda-sil \
	brda-sil@nowhere.com \
	--user_pass="abcd" \
	--role=subscriber \
	--allow-root

php -F -R
