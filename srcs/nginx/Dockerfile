FROM		alpine:3.17		AS base

RUN			apk add --update									\
				nginx											\
				openssl && \
			rm -f /var/cache/apk/*

FROM		base			AS packed

COPY		--chown=root:root nginx-selfsigned.key /etc/ssl/private/
COPY		--chown=root:root nginx-selfsigned.crt /etc/ssl/certs/
COPY		--chown=root:root nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT	[ "nginx" ]
CMD			[ "-g", "daemon off;" ]
