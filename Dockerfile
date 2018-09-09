
FROM golang:1.10.4-alpine3.8

RUN apk --update add git
RUN go get github.com/apisite/apisite
RUN go install github.com/apisite/apisite

FROM alpine:3.8

MAINTAINER Aleksey Kovrizhkin <lekovr+apisite@gmail.com>

ENV DOCKERFILE_VERSION  180909

RUN apk --update add curl make coreutils diffutils gawk git openssl musl-dev bash

WORKDIR /opt/apisite

COPY --from=0 /go/bin/apisite .

COPY sql sql
COPY tmpl tmpl
COPY static static
COPY Makefile .

# apisite default port
EXPOSE 8080

ENTRYPOINT ["/opt/apisite/apisite"]
