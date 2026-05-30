CC = hugo
PORT ?= 1313

s: serve
e: export
d: deploy

export:
	bash export.sh

serve:
	$(CC) serve --port $(PORT)

deploy:
	$(CC) --gc --minify
