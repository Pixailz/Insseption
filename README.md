# Insseption

## TODO

- all the bonuses and more
- do monitoring (ref B2BR) onto the makefile
  - decide how, maybe a file in each docker to stats out
  - which stat (only up ?)
- make the howto onto the makefile
  - finish the DOT ENV section

## HOWTO

### DOT ENV

TO REDACT

### MAKEFILE

the folloing rules have a variable `TARGET` to specify which container you wan't to affect, like `make exec TARGET=mariadb` will run `ash` (alpine `bash` shell) on a running mariadb container

- `up`
- `run`
- `build`
- `kill`
- `exec`

---

#### `up`
call `build`, and then call `docker compose up` to make the whole project UP and running

---

#### `run`
call `build`, and then call `docker compose run -it` to run a containers

---

#### `build`
call `$(SHARE_DIR)` and `$(ENV_FILE)`, and then call `docker compose build` to first build the containers

---

#### `kill`
call `docker compose kill` to kill all the current running containers

---

#### `exec`
call `docker compose exec -it` to pop a shell on a containers

---

#### `re`
call `clean` and then `up`, to clean the containers `data` folder and make it up again

---

#### `clean`
clean the ${HOME}/data folder, by removing it

---

#### `fclean`
call `clean`, and remove all volumes, networks, and images on the host

---

#### `$(ENV_FILE)`
copy the `./srcs/.env.template` onto `./srcs/.env`

---

#### `$(SHARE_DIR)`
make all the dir into the `${HOME}/data` folder
