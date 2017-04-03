FROM ruby:2.4

MAINTAINER Andy Nicholson <andrew@anicholson.net>

RUN apt-get update && \
    mkdir -p /usr/local/src/mode-mode

ENV app /usr/local/src/mode-mode

RUN mkdir -p $app

WORKDIR $app

ENV BUNDLE_PATH /gems

ADD . $app
