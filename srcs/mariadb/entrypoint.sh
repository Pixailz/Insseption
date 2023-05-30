#!/bin/ash

MYSQL_OPT="--user=mysql --verbose=0 --skip-name-resolve --skip-networking=0"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user="mysql" --ldata=/var/lib/mysql >/dev/null
	MYSQL_ROOT_PASS="1234"

	tmp_file=$(mktemp)

	cat << EOSQL > tmp_file
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '${MYSQL_ROOT_PASS}' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '${MYSQL_ROOT_PASS}' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASS}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS \`main_db\` CHARACTER SET utf8 COLLATE utf8_general_ci ;
EOSQL

	/usr/bin/mysqld --bootstrap ${MYSQL_OPT} < ${tmp_file}
	rm ${tmp_file}
fi

exec /usr/bin/mysqld --console ${MYSQL_OPT}
