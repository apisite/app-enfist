FROM ghcr.io/apisite/apisite:v0.6.4

MAINTAINER Aleksei Kovrizhkin <lekovr+apisite@gmail.com>

ENV DOCKERFILE_VERSION  211113

COPY sql sql
COPY tmpl tmpl
COPY static static
COPY Makefile .
