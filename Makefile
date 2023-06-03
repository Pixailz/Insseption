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

ESC					:=\x1b[
PRI					:=$(ESC)37m
SEC					:=$(ESC)38:5:208m
RST					:=$(ESC)00m

define USAGE
$(PRI)Makefile create the '$(SEC)$${HOME}/data$(RST)' dir automatically and also
copy the '$(SEC).env.template$(RST)' into '$(SEC).env$(RST)' if it not exists

the folloing rules have a variable $(SEC)TARGET$(RST) to set for specifying the
target to affect.

- $(SEC)up$(RST)
- $(SEC)run$(RST)
- $(SEC)build$(RST)
- $(SEC)kill$(RST)
- $(SEC)exec$(RST)

exemples:
'make exec $(SEC)TARGET=mariadb$(RST)'
	will run 'ash' (alpine bash shell) on a running mariadb container
'make up $(SEC)TARGET=nginx$(RST)'
	will make up nginx container


if $(SEC)TARGET$(RST) is not specified all the services are targeted

the exec rules can take a $(SEC)EXEC$(RST) variable wich specify what to
launch (ex: 'ash', 'ps aux')

	$(SEC)up$(RST)
		call 'build', and then call 'docker compose up' to make the whole
		project UP and running

	$(SEC)run$(RST)
		call 'build', and then call 'docker compose run -it' to run a containers

	$(SEC)build$(RST)
		call '$$(SHARE_DIR)' and '$$(ENV_FILE)', and then call 'docker compose
		build' to first build the containers

	$(SEC)kill$(RST)
		call 'docker compose kill' to kill all the current running containers

	$(SEC)exec$(RST)
		call 'docker compose exec -it' to pop a shell on a containers

	$(SEC)re$(RST)
		call 'clean' and then 'up'

	$(SEC)fre$(RST)
		call 'fclean' and then 'up', nd specify --no-cache to docker compose
		build that make redownloading the base image

	$(SEC)clean$(RST)
		clean the $${HOME}/data folder, by removing it

	$(SEC)fclean$(RST)
		call 'clean', and remove all volumes, networks, and images on the host

	$(SEC)$$(ENV_FILE)$(RST)
		copy the './srcs/.env.template' onto './srcs/.env'

	$(SEC)$$(SHARE_DIR)$(RST)
		make all the dir into the '$${HOME}/data' folder

	$(SEC)help$(RST)
		display this help message

endef
export USAGE


.PHONY:				up run build kill exec re clean fclean $(SHARE_DIR)

up:					build
	$(DOCKER_COMPOSE) up $(TARGET)

run:				build
	$(DOCKER_COMPOSE) run -it $(ENTRYPOINT) $(TARGET)

build:				$(SHARE_DIR) $(ENV_FILE)
	$(DOCKER_COMPOSE) build $(TARGET) $(RE_STR)

kill:
	$(DOCKER_COMPOSE) kill $(TARGET)

exec:
	$(DOCKER_COMPOSE) exec -it $(TARGET) ash

re:					clean up

fre:				fclean up

clean:
	sudo rm -rf $(SHARE_BASE)

fclean:				kill clean
	docker system prune -af
	docker stop $(shell docker ps -qa) 2>/dev/null; true
	docker rm $(shell docker ps -qa) 2>/dev/null; true
	docker rmi $(shell docker images -qa) 2>/dev/null; true
	docker volume rm $(shell docker volume ls -q) 2>/dev/null; true
	docker network rm $(shell docker network ls -q) 2>/dev/null; true

$(ENV_FILE):
	cp ./srcs/.env{.template,}

$(SHARE_DIR):
	$(call MKDIR,$(@))

help:
	@printf "%b" "$${USAGE}"
