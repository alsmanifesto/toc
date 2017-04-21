FROM alpine:edge
MAINTAINER Alfredo Sánchez "alfresanc@ciencias.unam.mx"
# Update package index and install mongo + go + git + curl
# libc-dev for solving issue with 'gcc'. (https://github.com/golang/go/issues/15394)
RUN \
  echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk add --update go git libc-dev curl libressl2.4-libssl && \
  apk add --no-cache mongodb && \
  rm /usr/bin/mongoperf

# Set up GOPATH, GOBIN
RUN mkdir -p /go/src /go/pkg
ENV GOPATH=/go \
    GOBIN=/go/bin

# Get TOC App dependencies (At build time)
RUN go get gopkg.in/mgo.v2 && \
    go get gopkg.in/mgo.v2/bson && \
    go get github.com/julienschmidt/httprouter

# Add current working directory
ADD https://github.com/alfresanc/toc/ $GOPATH/src/

VOLUME /data/db

COPY run.sh /root
RUN chmod +x /root/run.sh
ENTRYPOINT [ "/root/run.sh" ]

# Build it :)
# Every time I start the container I want to rebuild
# because I mount it when I use it for development
ENTRYPOINT \
    mongod && \
    go install /$GOPATH/server.go && \
    $GOBIN/server

# CMD [ "mongod" ]

# http://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
# Prefer ENTRYPOINT to CMD when building executable Docker image and you need a command always to be executed. 
# Additionally use CMD if you need to provide extra default arguments that could be overwritten from command line when docker container runs.

# Expose where the application wants to listen
EXPOSE 3000 27017

