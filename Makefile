PROJECT_DIRECTORY := ./srcs

ifeq ($(shell find $(PROJECT_DIRECTORY) -name '.env' 2> /dev/null),)
  $(error .env missing at $(PROJECT_DIRECTORY))
else
	include $(PROJECT_DIRECTORY)/.env
endif

QUIET := > /dev/null 2>&1

DOCKER_COMPOSE := $(shell \
	if docker compose version $(QUIET) >/dev/null 2>&1; then \
		echo 'docker compose'; \
	elif docker-compose version $(QUIET) >/dev/null 2>&1; then \
		echo 'docker-compose'; \
	fi)

ifeq ($(strip $(DOCKER_COMPOSE)),)
  $(error could not find docker compose command)
endif

DOCKER_COMPOSE := $(DOCKER_COMPOSE) --project-directory $(PROJECT_DIRECTORY)

all: setup_secrets setup_data_directories generate_certificates up

setup_secrets:
	bash ./setup_secrets.sh

generate_certificates:
	@ls $(HOST_SSL_CERTS_FOLDER) $(QUIET) || mkdir -p $(HOST_SSL_CERTS_FOLDER)
	@ls $(HOST_SSL_CERTS_FOLDER)/$(SSL_CERT_KEY_FILE) $(QUIET) \
        || openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(HOST_SSL_CERTS_FOLDER)/$(SSL_CERT_KEY_FILE) \
		-out $(HOST_SSL_CERTS_FOLDER)/$(SSL_CERT_FILE) \
		-subj "/CN=$(INCEPTION_SERVER_NAME)" \
		-addext "subjectAltName = DNS:$(INCEPTION_SERVER_NAME), DNS:localhost"

setup_data_directories:
	@ls $(HOST_DB_DATA_FOLDER) $(QUIET) || mkdir -p $(HOST_DB_DATA_FOLDER)
	@ls $(HOST_WEB_FOLDER) $(QUIET) || mkdir -p $(HOST_WEB_FOLDER)

up: down
	$(DOCKER_COMPOSE) up --build

down:
	$(DOCKER_COMPOSE) down

stop:
	$(DOCKER_COMPOSE) stop

clean:
	-sudo rm -rf $(HOST_DB_DATA_FOLDER);
	-sudo rm -rf $(HOST_WEB_FOLDER);
	-sudo rm -rf $(HOST_SSL_CERTS_FOLDER);

re: clean all

.PHONY: all setup_secrets generate_certificates setup_data_directories up down stop clean re
