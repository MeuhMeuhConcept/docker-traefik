.PHONY: help install start stop
.DEFAULT_GOAL := help

install: docker-compose.yml traefik.toml acme.json ## Install

docker-compose.yml:
	cp docker-compose.yml.dist $@

traefik.toml:
	cp traefik.toml.dist $@

acme.json:
	touch $@
	chmod 600 $@

start: install ## Run with docker stack
	docker stack deploy --compose-file docker-compose.yml traefik

stop: install ## Stop service
	docker stack rm traefik

help:
	@grep -E '^[a-zA-Z_-.]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
