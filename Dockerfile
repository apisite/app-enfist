FROM apisite/apisite:0.6

MAINTAINER Aleksei Kovrizhkin <lekovr+apisite@gmail.com>

ENV DOCKERFILE_VERSION  190327

COPY sql sql
COPY tmpl tmpl
COPY static static
COPY Makefile .
