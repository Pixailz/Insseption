FROM		alpine:3.17		AS base

RUN			apk add --update			\
				php						\
				php-fpm					\
				php-mysqli				\
				php-phar				\
				php-iconv				\
				mariadb-client			\
			&& rm -f /var/cache/apk/*

RUN			wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			-O /usr/local/bin/wp && \
			chmod +x ./usr/local/bin/wp

FROM		base			AS packed

RUN			adduser -S nginx &&	addgroup -S nginx
COPY		--chown=root:root www.conf /etc/php81/php-fpm.d
COPY		--chown=root:root entrypoint /run

ENTRYPOINT	[ "/run/entrypoint" ]
