FROM		alpine:3.17		AS base

RUN			apk add --update									\
				nginx											\
				openssl && \
			rm -f /var/cache/apk/*

FROM		base			AS packed

RUN			openssl req											\
				-x509											\
				-nodes											\
				-days 365										\
				-subj "/C=FR/ST=France/L=Angou/O=420verfl0w/OU=420verfl0w"	\
				-newkey rsa:2048								\
				-keyout /etc/ssl/private/nginx-selfsigned.key	\
				-out /etc/ssl/certs/nginx-selfsigned.crt

COPY		--chown=root:root nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT	[ "nginx" ]
CMD			[ "-g", "daemon off;" ]
