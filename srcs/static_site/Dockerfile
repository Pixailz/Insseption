FROM		alpine:3.17		AS packed

COPY		--chown=root:root entrypoint /run
COPY		--chown=root:root www /tmp/static_site

ENTRYPOINT	[ "/run/entrypoint" ]
