include ./config.mk

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

exec:
	$(DOCKER_COMPOSE) exec -it $(TARGET) ash

re:					clean up

clean:
	sudo rm -rf $(SHARE_BASE)

fclean:				kill clean
	docker system prune -af
	docker volume rm $(shell docker volume ls -q) ; 	true

$(SHARE_DIR):
	$(call MKDIR,$(@))
