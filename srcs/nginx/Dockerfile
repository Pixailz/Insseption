FROM		alpine:3.17		AS base

RUN			apk add --update \
				nginx \
				openssl \
			&& rm -f /var/cache/apk/*

#=#=#

FROM		base			AS packed

COPY		--chown=root:root default.conf /etc/nginx/http.d/default.conf
COPY		--chown=root:root entrypoint /run

ENTRYPOINT	[ "/run/entrypoint" ]
