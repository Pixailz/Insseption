FROM		alpine:3.17		AS base

RUN			apk add --update				\
				nginx						\
				openssl						\
			&& rm -f /var/cache/apk/*

FROM		base			AS packed

WORKDIR		/etc/nginx/ssl
RUN			openssl req											\
				-x509											\
				-newkey rsa:4096								\
				-sha256											\
				-nodes											\
				-days 365										\
				-subj "/C=FR/ST=Charen/L=Angou/O=420verfl0w/OU=Security/CN=420overfl0w"	\
				-keyout ./nginx-selfsigned.key	\
				-out ./nginx-selfsigned.crt


COPY		--chown=root:root default.conf /etc/nginx/http.d/default.conf

WORKDIR		/

ENTRYPOINT	[ "nginx" ]
CMD			[ "-g", "daemon off;" ]
