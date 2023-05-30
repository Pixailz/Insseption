FROM		alpine:3.17		AS base

RUN			apk update && apk add \
				php				\
				php-fpm			\
				php-phar		\
				php-mysqli		\
				php-mbstring	\
				mariadb-client	\
				curl && \
			rm -f /var/cache/apk/*

RUN			curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar	&& \
			chmod +x ./wp-cli.phar																&& \
			mv wp-cli.phar /usr/local/bin/wp													&& \
			wp cli update

FROM		base			AS packed

# WORKDIR create dir if not exist
WORKDIR		/run/php
WORKDIR		/var/www/html
WORKDIR		/

COPY		--chown=root:root www.conf /etc/php/7.3/fpm/pool.d
COPY		--chown=root:root entrypoint /run

ENTRYPOINT	[ "/run/entrypoint" ]
