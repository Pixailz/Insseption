#!/bin/ash

if [ ! -d /run/mysql ]; then
	mkdir -p /run/mysql
	chown -R mysql:mysql /run/mysql
fi

if [ ! -d /var/lib/mysql/mysql ]; then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user="mysql" --ldata=/var/lib/mysql >/dev/null
fi

while [ 1 ]; do
	sleep 2
done
