# apisite project makefile

SHELL          = /bin/bash
CFG           ?= .env
PRG           ?= $(shell basename $$PWD)

# -----------------------------------------------------------------------------
# Runtime data

APP_SITE      ?= $(PRG).dev.lan

PGDATABASE    ?= $(PRG)
PGUSER        ?= $(PRG)
PGPASSWORD    ?= $(shell < /dev/urandom tr -dc A-Za-z0-9 | head -c14; echo)
PGHOST        ?= localhost
PGSSLMODE     ?= disable
PGAPPNAME     ?= $(PRG)

# -----------------------------------------------------------------------------
# poma settings

SQL_ROOT      ?= sql
BUILD_DIR     ?= .build
POMA_MAKE     ?= $(SQL_ROOT)/poma/Makefile

allpak        ?= rpc enfist

%-all: POMA_PKG=poma $(allpak)
%-default: POMA_PKG=$(allpak)

# -----------------------------------------------------------------------------
# Docker image config

# application name, docker-compose prefix

# Hardcoded in docker-compose.yml service name
DC_SERVICE    ?= app

# Generated docker image
DC_IMAGE      ?= apisite/apisite:0.5

# docker-compose version
DC_VER        ?= 1.14.0

# dcape network connect to, must be set in .env
DCAPE_NET     ?= dcape_default

# ------------------------------------------------------------------------------
# Дополнения файла .env
define CONFIG_DEFAULT

# dcape site
APP_SITE=$(APP_SITE)

# dcape net
DCAPE_NET=$(DCAPE_NET)

endef
export CONFIG_DEFAULT

# -----------------------------------------------------------------------------

include $(POMA_MAKE)

# -----------------------------------------------------------------------------

.PHONY: all help gen build-standalone coverage cov-html build test lint fmt vet vendor up down build-docker clean-docker

##
## Available targets are:
##

# default: show target list
all: help

## Show available make targets
help:
	@grep -A 1 -h "^##" Makefile $(POMA_MAKE) | less

## Remove all temp files
clean: poma-clean

# ------------------------------------------------------------------------------
## get binary for local use
deps-local:
	go get github.com/apisite/apisite
	go install github.com/apisite/apisite

## run standalone application
run-local:
	apisite --db_debug --db_schema rpc

run:
	PGHOST=${PGHOST} PGDATABASE=${PGDATABASE} PGUSER=${PGUSER} PGPASSWORD=${PGPASSWORD} \
	./apisite --db.schema rpc --http_addr :8080

# ------------------------------------------------------------------------------
# Misc
define TEST_FILE
# test file for API
VAR=VAL
endef

test-api:
#	@curl -gs 'http://localhost:8080/rpc/tag_vars?code=_enfist_test_' | jq -r '.'
#	@curl -gs -d '{"code":"_enfist_test_"}' http://localhost:8080/rpc/tag_vars | jq -r '.'
	echo "$$TEST_FILE" | jq -R -sc ". | {\"code\":\"_enfist_test2_\",\"data\":.}" \
	    | curl -gsd @- "http://localhost:8080/rpc/tag_set" | jq '.'


# ------------------------------------------------------------------------------
# Docker part
# ------------------------------------------------------------------------------

## Start service in container
up:
up: CMD=up -d $(DC_SERVICE)
up: dc

## Stop service
down:
down: CMD=rm -f -s $(DC_SERVICE)
down: dc

## Build docker image
build-docker:
	@$(MAKE) -s dc CMD="build --force-rm $(DC_SERVICE)"

## Build docker image without cache
build-docker-forced:
	@$(MAKE) -s dc CMD="build --no-cache --force-rm $(DC_SERVICE)"

## Remove docker image & temp files
clean-docker:
	[[ "$$($(DOCKER_BIN) images -q $(DC_IMAGE) 2> /dev/null)" == "" ]] || $(DOCKER_BIN) rmi $(DC_IMAGE)

## Build docker image for distribution
build-dist: DC_SERVICE=dist
build-dist: build-docker

# ------------------------------------------------------------------------------

# $$PWD используется для того, чтобы текущий каталог был доступен в контейнере по тому же пути
# и относительные тома новых контейнеров могли его использовать
## run docker-compose
dc: docker-compose.yml
	@VERSION="$$(git describe --tags)" ; \
	docker run --rm  -i \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  -v $$PWD:$$PWD \
	  -w $$PWD \
	  --env=DC_IMAGE=$(DC_IMAGE) \
	  --env=PRG=$(PRG) \
	  --env=VERSION=$$VERSION \
	  docker/compose:$(DC_VER) \
	  -p $(PRG) \
	  $(CMD)

