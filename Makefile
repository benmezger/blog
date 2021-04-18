CC = hugo
PORT ?= 1313
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

s: serve
o: export-orgs

serve:
	$(CC) serve --port $(PORT)

export-orgs:
	emacs \
		--batch \
		-l ~/.emacs.d/init.el \
		-l "$(ROOT_DIR)/org_to_hugo.el" \
		--eval "(benmezger/org-roam-export-all)"

deploy:
	./deploy.sh
