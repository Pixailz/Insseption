SHARE_BASE			:= ${HOME}/data

SHARE_DIR			:= $(SHARE_BASE)/nginx		\
					   $(SHARE_BASE)/mariab		\
					   $(SHARE_BASE)/wordpress

DOCKER_COMPOSE		:= docker compose -f ./srcs/docker-compose.yaml

ifeq ($(COMPOSE_TARGET),)
COMPOSE_TARGET		:= nginx
endif

RE_STR				:=

SHELL				:= /bin/bash

MKDIR				= \
$(shell [ -f $(1) ] && rm -f $(1)) \
$(shell [ ! -d $(1) ] && mkdir -p $(1))

ifeq ($(findstring re,$(MAKECMDGOALS)),re)
RE_STR				:= --no-cache
endif

.PHONY:				re up build $(SHARE_DIR)

up:					build
	$(DOCKER_COMPOSE) up

build:				$(SHARE_DIR)
	$(DOCKER_COMPOSE) build $(RE_STR)

kill:
	$(DOCKER_COMPOSE) kill

re:					up

$(SHARE_DIR):
	$(call MKDIR,$(@))
