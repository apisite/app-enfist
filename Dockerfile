FROM apisite/apisite:0.6.1

MAINTAINER Aleksei Kovrizhkin <lekovr+apisite@gmail.com>

ENV DOCKERFILE_VERSION  191107

COPY sql sql
COPY tmpl tmpl
COPY static static
COPY Makefile .
