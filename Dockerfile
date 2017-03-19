FROM ruby:2.4

MAINTAINER Andy Nicholson <andrew@anicholson.net>

RUN apt-get update && \
    mkdir -p /usr/local/src/mode-mode


ADD . /usr/local/src/mode-mode
