FROM apisite/apisite:0.5

MAINTAINER Aleksey Kovrizhkin <lekovr+apisite@gmail.com>

ENV DOCKERFILE_VERSION  180917

COPY sql sql
COPY tmpl tmpl
COPY static static
COPY Makefile .
