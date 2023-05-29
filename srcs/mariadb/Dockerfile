FROM		alpine:3.17 AS base

RUN			apk add --update		\
				mariadb				\
				mariadb-client		\
				pwgen

COPY		--chown=root:root entrypoint.sh /run

ENTRYPOINT	[ "/run/entrypoint.sh" ]
# RUN		mariadb-secure-installation
