FROM composer:2.2

RUN apk add --no-cache tini tzdata

RUN addgroup -g 1000 adidas \
    && adduser -u 1000 -G adidas -D adidas

WORKDIR /src/app

COPY . .

RUN set -xe; \
    composer install; \
    cp includes/config.environment.inc.php includes/config.inc.php; \
    chown -R adidas:adidas /src/app

ENV PORT 8080
EXPOSE 8080
USER adidas
ENTRYPOINT [ "sh", "-c", "tini -- php -S 0.0.0.0:$PORT" ]
