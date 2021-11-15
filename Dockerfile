#FROM apisite/apisite:0.6.1
FROM ghcr.io/apisite/apisite:v0.6.10

MAINTAINER Aleksei Kovrizhkin <lekovr+apisite@gmail.com>

ENV DOCKERFILE_VERSION  21116

COPY sql sql
COPY tmpl tmpl
COPY static static
COPY Makefile .
