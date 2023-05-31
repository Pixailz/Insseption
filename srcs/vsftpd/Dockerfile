FROM		alpine:3.17		AS base

RUN			apk add --update			\
				openssl					\
				vsftpd					\
			&& rm -f /var/cache/apk/*

FROM		base			AS packed

RUN			openssl req											\
				-x509											\
				-newkey rsa:4096								\
				-sha256											\
				-nodes											\
				-days 365										\
				-subj "/C=FR/ST=Charen/L=Angou/O=420verfl0w/OU=Security/CN=420overfl0w"	\
				-keyout /etc/vsftpd/vsftpd.key	\
				-out /etc/vsftpd/vsftpd.crt

ENTRYPOINT	[ "/run/entrypoint" ]
