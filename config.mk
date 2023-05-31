SHELL				:= /bin/bash

SHARE_BASE			:= ${HOME}/data
SHARE_DIR			:= $(SHARE_BASE)/mariadb			\
					   $(SHARE_BASE)/www_root			\
					   $(SHARE_BASE)/log/wordpress		\
					   $(SHARE_BASE)/log/nginx			\
					   $(SHARE_BASE)/log/mariadb

DOCKER_COMPOSE		:= docker compose -f ./srcs/docker-compose.yaml

MKDIR				= \
$(shell [ -f $(1) ] && rm -f $(1)) \
$(shell [ ! -d $(1) ] && mkdir -p $(1))

ifeq ($(findstring re,$(MAKECMDGOALS)),re)
RE_STR				:= --no-cache
endif

RE_STR				?=
TARGET				?=
