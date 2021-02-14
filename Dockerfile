FROM peaceiris/hugo:v0.80.0

RUN apk add --no-cache --update git
ENTRYPOINT ["sh", "docker-entrypoint.sh"]
