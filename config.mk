SHELL				:= /bin/bash

SHARE_BASE			:= ${HOME}/data
SHARE_DIR			:= mariadb \
					   nginx \
					   www_root \
					   vsftpd \
					   portainer \
					   log/wordpress \
					   log/nginx \
					   log/mariadb

SHARE_DIR			:= $(addprefix $(SHARE_BASE)/,$(SHARE_DIR))

DOCKER_COMPOSE		:= docker compose -f ./srcs/docker-compose.yaml

MKDIR				= \
$(shell [ -f $(1) ] && rm -f $(1)) \
$(shell [ ! -d $(1) ] && mkdir -p $(1))

ifeq ($(findstring fre,$(MAKECMDGOALS)),fre)
RE_STR				:= --no-cache
endif

ifneq ($(ENTRY),)
ENTRYPOINT				:= --entrypoint $(ENTRY)
endif

RE_STR				?=
TARGET				?=

ENV_FILE			:= srcs/.env
