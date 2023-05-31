FROM		alpine:3.17		AS base

RUN			apk add --update			\
				php							\
				php-common					\
				php-fpm						\
				php-phar					\
				php-mysqli					\
				php-mbstring				\
				mariadb-client				\
				curl						\
				# DEBUG ONLY
				# netcat-openbsd				\
				# iputils \
			&& rm -f /var/cache/apk/*

RUN			curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar	&& \
			chmod +x ./wp-cli.phar																&& \
			mv wp-cli.phar /usr/local/bin/wp													&& \
			wp cli update

FROM		base			AS packed

WORKDIR		/run/php
WORKDIR		/

RUN			adduser -S nginx &&	addgroup -S nginx
COPY		--chown=root:root www.conf /etc/php81/php-fpm.d
COPY		--chown=root:root entrypoint /run

ENTRYPOINT	[ "/run/entrypoint" ]
