FROM alpine:latest

LABEL maintainer="extrafein"

ARG ARCHITECTURE
ARG LATEST_VERSION

RUN apk add --no-cache curl linux-pam

RUN mkdir /app
WORKDIR /app

RUN LATEST_VERSION=$(curl -s "https://mmonit.com/monit/dist/binary/" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n1) \
    && curl -sL "https://mmonit.com/monit/dist/binary/$LATEST_VERSION/monit-$LATEST_VERSION-$ARCHITECTURE.tar.gz" | tar -xz

EXPOSE 2812

HEALTHCHECK CMD curl -f http://localhost:2812 || exit 1

CMD ["/app/bin/monit","-c","/app/conf/monitrc","-I"]
