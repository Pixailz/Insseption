FROM		alpine:3.17		AS packed

COPY		--chown=root:root entrypoint /run
COPY		--chown=root:root static_site /tmp/static_site

ENTRYPOINT	[ "/run/entrypoint" ]
