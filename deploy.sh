#!/usr/bin/env bash
set -euo pipefail

blog_head=$(git rev-parse HEAD)

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
printf "\033[1;31mDeploying commit $blog_head of 'blog' \n\033[1;0m"

hugo --gc --minify

# Add newly created/updated files
cd public

## Commit and push
if [[ `git status --porcelain` ]]; then
  git add .

  git commit -m "Automatic site rebuild of $(date)

  
  This is a rebuild of commit '$blog_head'
  Respository: github.com/benmezger/blog"
else
  printf "No changes detected.\n"
fi

git push origin master

# Move back to blog/
cd ..

rsync -v -rz --checksum --delete public/ root@seds.nl:/var/www/seds
