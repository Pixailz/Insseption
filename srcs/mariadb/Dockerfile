FROM		alpine:3.17		AS base

RUN			apk add --update				\
				mariadb						\
				mariadb-client				\
			&& rm -f /var/cache/apk/*

FROM		base			AS packed

COPY		--chown=root:root entrypoint /run
COPY		--chown=root:root my.cnf /etc/mysql/
RUN			mkdir -p /var/log/mariadb && chown mysql:mysql /var/log/mariadb

ENTRYPOINT	[ "/run/entrypoint" ]
