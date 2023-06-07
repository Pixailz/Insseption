FROM		alpine:3.17		AS base

RUN			apk add --update \
				openssl \
			&& rm -f /var/cache/apk/*

#=#=#

FROM		base		AS packed

COPY		--chown=root:root portainer.db data/
COPY		--chown=root:root entrypoint latest.tar.gz /run

ENTRYPOINT	[ "/run/entrypoint" ]
