FROM		alpine:3.17		AS base

RUN			apk add --update		\
				mariadb && \
			rm -f /var/cache/apk/*

FROM		base			AS packed

COPY		--chown=root:root entrypoint /run

ENTRYPOINT	[ "/run/entrypoint" ]

HEALTHCHECK --start-period=5s CMD pgrep mysqld
