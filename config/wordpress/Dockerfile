ARG PHP_VERSION
FROM wordpress:${PHP_VERSION} as dev

RUN apt-get update && apt-get install -y zip unzip
RUN mkdir deploy
RUN mkdir backup

