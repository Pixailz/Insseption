SHARE_DIR			:= /home/kali/data

DOCKER_COMPOSE		:= docker compose -f ./srcs/docker-compose.yaml

COMPOSE_TARGET		:= mariadb

RE_STR				:=

ifeq ($(findstring re,$(MAKECMDGOALS)),re)
RE_STR				:= --no-cache
endif

.PHONY:				run re build $(SHARE_DIR)

run:				build
	$(DOCKER_COMPOSE) run -it $(COMPOSE_TARGET)

up:					build
	$(DOCKER_COMPOSE) up $(COMPOSE_TARGET)

build:				$(SHARE_DIR)
	$(DOCKER_COMPOSE) build $(COMPOSE_TARGET) $(RE_STR)

re:					run

$(SHARE_DIR):
	$(shell [ -d $(SHARE_DIR) ] || mkdir -p $(SHARE_DIR))
