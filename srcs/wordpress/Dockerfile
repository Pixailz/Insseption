FROM		alpine:3.17		AS base

RUN			apk add --update \
				php81 \
				php81-mysqli \
				redis \
				mariadb-client \
				# RECOMMENDED PHP MODULES
				php81-curl \
				php81-dom \
				php81-exif \
				php81-fileinfo \
				php81-mbstring \
				php81-zip \
				php81-gd \
				php81-intl \
				php81-fpm \
				php81-phar \
				php81-iconv \
				php81-pecl-imagick \
			&& rm -f /var/cache/apk/*

COPY		--chown=root:root --chmod=755 wp /usr/local/bin/

#=#=#

FROM		base			AS packed

RUN			adduser -S nginx &&	addgroup -S nginx
COPY		--chown=root:root www.conf /etc/php81/php-fpm.d
COPY		--chown=root:root entrypoint latest.tar.gz /run

ENTRYPOINT	[ "/run/entrypoint" ]
