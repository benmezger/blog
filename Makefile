CC = hugo
PORT ?= 1313

s: serve
e: export
d: deploy
t: test

export:
	bash scripts/export.sh

serve:
	$(CC) serve --port $(PORT)

deploy:
	$(CC) --gc --minify

# test to make sure all pages have their respective markdown generated
test:
	# requires netlify dev to be running
	bash scripts/test-curl-markdown.sh

test-prod:
	# requires netlify dev to be running
	bash scripts/test-curl-markdown.sh https://seds.nl

test-static:
	# checks built public/ dir — no server needed, safe for CI
	bash scripts/test-static-markdown.sh
