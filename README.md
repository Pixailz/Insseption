# Insseption

## TODO

- put conf in conf dir etc.
- put the brief onto the makefile, portainer already do the stat
  - finish the DOT ENV section

## SOME DOCX

First, docker / compose have a very good documentation, check out some link:

- [Dockerfile](https://docs.docker.com/engine/reference/builder/)
  - [`docker` (CLI)](https://docs.docker.com/engine/reference/commandline/cli/)
- [Compose](https://docs.docker.com/compose/compose-file/)
  - [Compose V3](https://docs.docker.com/compose/compose-file/compose-file-v3/)
  - [`compose` (CLI)](https://docs.docker.com/compose/reference/)

### What's docker

https://www.youtube.com/watch?v=-YnMr1lj4Z8
> a very good video on how docker works

TL;DR
Docker use Containerd, that manage little Container, that use Runc, to unshare Namespaces to simulate a 'spaces' where an user can be root, but stay a regular user outside of that namespace.

### How to install

- [installing docker engine](https://docs.docker.com/engine/install/)
  - [Debian](https://docs.docker.com/engine/install/debian)
  - [Ubuntu](https://docs.docker.com/engine/install/ubuntu)
- [installing docker rootless](https://docs.docker.com/engine/security/rootless/)
> installing in rootless means that docker will not have root privileges on host
> more secure in prod

## HOWTO

### DOTENV

```bash
# MAIN
## nothing mean disable
DEBUG=

# WORDPRESS
## WordPress normal user
NORMAL_USER="brda-sil"
## normal user password
NORMAL_PASS="abcd"
## WordPress admin user
ADMIN_USER="pix"
## admin user password (also used in the extra services)
ADMIN_PASS="1234"
## WordPress title
WP_TITLE="Mon Petit Site Sous WordPress"
## base name of the WordPress installtion
WP_ROOT="wordpress"

# MARIADB
## database name
DB_NAME="main_db"

# FTP
## port for the ftp, default 21
FTP_PORT=
## data port for the ftp, default 20
FTP_DATA_PORT=
## passive min port for the ftp, default 10000
FTP_PASV_MIN_PORT=
## passive max port for the ftp, default 10100
FTP_PASV_MAX_PORT=

# CERTIFICATS
## all the subject of the ssl key
CERT_SUBJ="/C=FR/ST=Charen/L=Angou/O=420verfl0w/OU=Security/CN=420overfl0w"
```

---

### MAKEFILE


```txt
make all the dir into the `${HOME}/data` folder
$(PRI)Makefile create the '$${HOME}/data' dir automatically and also
copy the '.env.template' into '.env' if it not exists

the folloing rules have a variable TARGET to set for specifying the
target to affect.

- up
- run
- build
- kill
- exec

exemples:
'make exec TARGET=mariadb'
	will run 'ash' (alpine bash shell) on a running mariadb container
'make up TARGET=nginx'
	will make up nginx container


if TARGET is not specified all the services are targeted

the exec rules can take a EXEC variable wich specify what to
launch (ex: 'ash', 'ps aux')

	up
		call 'build', and then call 'docker compose up' to make the whole
		project UP and running

	run
		call 'build', and then call 'docker compose run -it' to run a containers

	build
		call '$$(SHARE_DIR)' and '$$(ENV_FILE)', and then call 'docker compose
		build' to first build the containers

	kill
		call 'docker compose kill' to kill all the current running containers

	exec
		call 'docker compose exec -it' to pop a shell on a containers

	re
		call 'clean' and then 'up'

	fre
		call 'fclean' and then 'up', nd specify --no-cache to docker compose
		build that make redownloading the base image

	clean
		clean the $${HOME}/data folder, by removing it

	fclean
		call 'clean', and remove all volumes, networks, and images on the host

	$$(ENV_FILE)
		copy the './srcs/.env.template' onto './srcs/.env'

	$$(SHARE_DIR)
		make all the dir into the '$${HOME}/data' folder

	help
		display this help message
```
