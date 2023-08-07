# use most optimized base image
FROM alpine:latest

# that's me ;-)
LABEL maintainer="extrafein"

# get value from docker-compose.yaml
ARG architecture

# prepare variable
ARG latest_version

RUN apk add --no-cache curl linux-pam

# prepare app directory
RUN mkdir /app
WORKDIR /app

# evaluate latest monit version and download it
RUN latest_version=$(curl -s "https://mmonit.com/monit/dist/binary/" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n1)
RUN curl -sL "https://mmonit.com/monit/dist/binary/$latest_version/monit-$latest_version-$architecture.tar.gz" | tar -xz --strip-components=1

# expose port for monit
EXPOSE 2812

# set basic healthcheck
HEALTHCHECK CMD curl -f http://localhost:2812 || exit 1

# set start command for container
CMD ["/app/bin/monit","-c","/app/conf/monitrc","-I"]
