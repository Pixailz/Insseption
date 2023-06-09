FROM		alpine:3.17		AS base

RUN			apk add --update \
				curl \
				php \
				php-session \
				php-mysqli \
			&& rm -f /var/cache/apk/*

#=#=#

FROM		base			AS packed

COPY		--chown=root:root index.php /var/www/html/adminer/index.php
COPY		--chown=root:root hydra.css /var/www/html/adminer/adminer.css
COPY		--chown=root:root entrypoint /run

ENTRYPOINT	[ "/run/entrypoint" ]
