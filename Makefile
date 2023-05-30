SHARE_BASE			:= ${HOME}/data

SHARE_DIR			:= $(SHARE_BASE)/nginx			\
					   $(SHARE_BASE)/mariadb		\
					   $(SHARE_BASE)/wordpress

DOCKER_COMPOSE		:= docker compose -f ./srcs/docker-compose.yaml

SHELL				:= /bin/bash

MKDIR				= \
$(shell [ -f $(1) ] && rm -f $(1)) \
$(shell [ ! -d $(1) ] && mkdir -p $(1))

ifeq ($(findstring re,$(MAKECMDGOALS)),re)
RE_STR				:= --no-cache
endif

RE_STR				?=
TARGET				?=

.PHONY:				re up build $(SHARE_DIR)

up:					build
	$(DOCKER_COMPOSE) up $(TARGET)

run:				build
	$(DOCKER_COMPOSE) run -it $(TARGET)

build:				$(SHARE_DIR)
	@printf "Building target: %s\n" $(TARGET)
	$(DOCKER_COMPOSE) build $(TARGET) $(RE_STR)

kill:
	$(DOCKER_COMPOSE) kill $(TARGET)

re:					up

fclean:				kill
	docker system prune -af
	docker volume rm $(shell docker volume ls -q) ; true
	sudo rm -rf $(SHARE_BASE)

$(SHARE_DIR):
	$(call MKDIR,$(@))
