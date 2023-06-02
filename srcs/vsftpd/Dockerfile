FROM		alpine:3.17		AS base

RUN			apk add --update \
				openssl \
				vsftpd \
			&& rm -f /var/cache/apk/*

#=#=#

FROM		base			AS packed

ARG			FTP_USER \
			FTP_PASS

RUN			adduser -h "/home/${FTP_USER}" -s /sbin/nologin ${FTP_USER} -D -H && \
			printf "${FTP_USER}:${FTP_PASS}\n" | chpasswd 2>/dev/null

COPY		--chown=root:root entrypoint /run
ENTRYPOINT	[ "/run/entrypoint" ]
