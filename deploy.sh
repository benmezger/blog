#!/usr/bin/env bash
set -euo pipefail

# build netlify public pages
hugo --destination generated_public/ --gc --minify

blog_head=$(git rev-parse HEAD)

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
printf "\033[1;31mDeploying commit $blog_head of 'blog' \n\033[1;0m"

echo "Removing public/"
rm -rf public/

git clone https://github.com/benmezger/benmezger.github.io.git public
rm -rf public/*

hugo --gc --minify --config gh_config.yaml

# Add newly created/updated files
cd public

git config user.email "me@benmezger.nl"
git config user.name "Ben Mezger"

## Commit and push
if [[ $(git status --porcelain) ]]; then
	git add .

	git commit -m "Automatic site rebuild of $(date)

  This is a rebuild of commit '$blog_head'
  Respository: github.com/benmezger/blog"
else
	printf "No changes detected.\n"
fi

git push -f -q https://$GITHUB_TOKEN@github.com/benmezger/benmezger.github.io.git master
