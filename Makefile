include env_make
NS = eason
VERSION ?= latest

REPO = janus
NAME = janus
INSTANCE = gateway

.PHONY: build push shell run start stop rm release

build:
	docker build --no-cache -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)

shell:
	docker exec -it $(NAME)-$(INSTANCE) /bin/bash

run:
	docker run -it --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

start:
	docker start -ai $(NAME)-$(INSTANCE)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm $(NAME)-$(INSTANCE)

release: build
	make push -e VERSION=$(VERSION)

default: build
