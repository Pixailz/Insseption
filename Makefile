# CONFIG
SHELL				:= /bin/bash
DOCKER_COMPOSE		:= docker compose -f ./srcs/docker-compose.yaml
CURL				:= curl -L -\#
ENV_FILE			:= srcs/.env

# VOLUMES DIR
SHARE_BASE			:= ${HOME}/data
SHARE_DIR			:= mariadb \
					   nginx \
					   www_root \
					   vsftpd \
					   portainer \
					   redis \
					   log/wordpress \
					   log/nginx \
					   log/mariadb \
					   log/vsftpd \
					   log/adminer \
					   log/redis

SHARE_DIR			:= $(addprefix $(SHARE_BASE)/,$(SHARE_DIR))

# PACKAGE TO DOWNLOAD
WORDPRESS_PACKAGE	:= srcs/wordpress/latest.tar.gz
WP_CLI_PACKAGE		:= srcs/wordpress/wp
PORTAINER_PACKAGE	:= srcs/portainer/latest.tar.gz

WORDPRESS_LINK		:= https://wordpress.org/latest.tar.gz
PORTAINER_LINK		:= https://github.com/portainer/portainer/releases/download/2.18.3/portainer-2.18.3-linux-amd64.tar.gz
WP_CLI_LINK			:= https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

PACKAGES			:= $(WORDPRESS_PACKAGE) $(PORTAINER_PACKAGE) $(WP_CLI_PACKAGE)

# UTILS
MKDIR				= \
$(shell [ -f $(1) ] && rm -f $(1)) \
$(shell [ ! -d $(1) ] && mkdir -p $(1))

ifeq ($(findstring fre,$(MAKECMDGOALS)),fre)
RE_STR				:= --no-cache
endif

ifneq ($(ENTRY),)
ENTRYPOINT			:= --entrypoint $(ENTRY)
endif

RE_STR				?=
TARGET				?=

ESC					:=\x1b[
R					:=$(ESC)38;5;196m
G					:=$(ESC)38;5;112m
B					:=$(ESC)38;5;27m
O					:=$(ESC)38;5;208m

PRI					:=$(G)
SEC					:=$(O)
RST					:=$(ESC)00m

define USAGE
$(PRI)Makefile create the '$(SEC)$${HOME}/data$(PRI)' dir automatically and also
copy the '$(SEC).env.template$(PRI)' into '$(SEC).env$(PRI)' if it not exists

the folloing rules have a variable $(SEC)TARGET$(PRI) to set for specifying the
target to affect.

- $(SEC)up$(PRI)
- $(SEC)run$(PRI)
- $(SEC)build$(PRI)
- $(SEC)kill$(PRI)
- $(SEC)exec$(PRI)

exemples:
'make exec $(SEC)TARGET=mariadb$(PRI)'
	will run 'ash' (alpine bash shell) on a running mariadb container
'make up $(SEC)TARGET=nginx$(PRI)'
	will make up nginx container


if $(SEC)TARGET$(PRI) is not specified all the services are targeted

the exec rules can take a $(SEC)EXEC$(PRI) variable wich specify what to
launch (ex: 'ash', 'ps aux')

	$(SEC)up$(PRI)
		call 'build', and then call 'docker compose up' to make the whole
		project UP and running

	$(SEC)run$(PRI)
		call 'build', and then call 'docker compose run -it' to run a containers

	$(SEC)build$(PRI)
		call '$$(SHARE_DIR)' and '$$(ENV_FILE)', and then call 'docker compose
		build' to first build the containers

	$(SEC)kill$(PRI)
		call 'docker compose kill' to kill all the current running containers

	$(SEC)exec$(PRI)
		call 'docker compose exec -it' to pop a shell on a containers

	$(SEC)re$(PRI)
		call 'clean' and then 'up'

	$(SEC)fre$(PRI)
		call 'fclean' and then 'up', nd specify --no-cache to docker compose
		build that make redownloading the base image

	$(SEC)clean$(PRI)
		clean the $${HOME}/data folder, by removing it

	$(SEC)fclean$(PRI)
		call 'clean', and remove all volumes, networks, and images on the host

	$(SEC)reset_env$(PRI)
		copy the './srcs/.env.template' onto './srcs/.env' and then read from
		stdin the NORMAL_PASS and ADMIN_PASS

	$(SEC)$$(ENV_FILE)$(PRI)
		call 'reset_env'

	$(SEC)$$(SHARE_DIR)$(PRI)
		make all the dir into the '$${HOME}/data' folder

	$(SEC)help$(PRI)
		display this help message
$(RST)
endef
export USAGE

SET_VAR				= \
var_pos="$$(grep -n $(1) ./srcs/.env | cut -d':' -f1)" ; \
sed -i "$${var_pos}d" ./srcs/.env ; \
sed -i "$${var_pos}i$(1)=$(2)" ./srcs/.env ; \
printf "var %b%s%b " "$(G)" "$(1)" "$(RST)" ; \
printf "set to %b%s%b\n" "$(R)" "$(2)" "$(RST)" ;

SET_PASS			= \
printf "%bNormal%b pass\n" "$(G)" "$(RST)" ; \
read -s NORMAL_PASS ; \
$(call SET_VAR,NORMAL_PASS,$${NORMAL_PASS}) \
printf "%bAdmin%b pass\n" "$(R)" "$(RST)" ; \
read -s ADMIN_PASS ; \
$(call SET_VAR,ADMIN_PASS,$${ADMIN_PASS})


# RULES
.PHONY:				up run build kill exec re clean fclean make_sym_link $(SHARE_DIR)

up:					build
	$(DOCKER_COMPOSE) up $(TARGET)

run:				build
	$(DOCKER_COMPOSE) run -it $(ENTRYPOINT) $(TARGET)

build:				$(PACKAGES) make_sym_link $(SHARE_DIR) $(ENV_FILE)
	$(DOCKER_COMPOSE) build $(TARGET) $(RE_STR)

kill:
	$(DOCKER_COMPOSE) kill $(TARGET)

exec:
	$(DOCKER_COMPOSE) exec -it $(TARGET) ash

$(WORDPRESS_PACKAGE):
	$(CURL) $(WORDPRESS_LINK) --output $@

$(WP_CLI_PACKAGE):
	$(CURL) $(WP_CLI_LINK) --output $@

$(PORTAINER_PACKAGE):
	$(CURL) $(PORTAINER_LINK) --output $@

make_sym_link:
ifeq ($(shell [ -L ./data_dir ] && printf "1" || printf "0" ),0)
	ln -s ${HOME}/data ${PWD}/data_dir
endif

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

reset_env:
	cp -f ./srcs/.env{.template,}
	@$(call SET_PASS)

$(ENV_FILE):		reset_env

$(SHARE_DIR):
	$(call MKDIR,$(@))

help:
	@printf "%b" "$${USAGE}"
