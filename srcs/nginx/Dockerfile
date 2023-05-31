FROM		alpine:3.17		AS base

RUN			apk add --update				\
				nginx						\
				openssl						\
				# DEBUG ONLY
				# netcat-openbsd				\
				# iputils \
			&& rm -f /var/cache/apk/*

FROM		base			AS packed

RUN			openssl req											\
				-x509											\
				-newkey rsa:4096								\
				-sha256											\
				-nodes											\
				-days 365										\
				-subj "/C=FR/ST=Angou/L=Angou/O=420verfl0w/OU=420/CN=420overfl0w/"	\
				-keyout /etc/ssl/private/nginx-selfsigned.key	\
				-out /etc/ssl/certs/nginx-selfsigned.crt

COPY		--chown=nginx:nginx nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT	[ "nginx" ]
CMD			[ "-g", "daemon off;" ]
