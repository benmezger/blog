CC = hugo
PORT ?= 1313
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ORG_DIR := "$(HOME)/workspace/org/roam"
ORG_FILES = $(shell find $(ORG_DIR) -type f -name '*.org')

s: serve
e: export
d: deploy

export: $(ORG_FILES)
	for file in $^; do \
		echo "Running doomscript for $${file}"; \
		doomscript $(HOME)/.doom.d/bin/org2blog "$${file}"; \
	done

serve:
	$(CC) serve --port $(PORT)

deploy:
	./deploy.sh

