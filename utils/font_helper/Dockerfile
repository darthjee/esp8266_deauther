FROM ruby:3.2.4 AS base

RUN useradd -u 1000 app; \
    mkdir -p /home/app/app; \
    chown app.app -R /home/app

WORKDIR /home/app/app

RUN gem update --system; \
    gem install bundler:2.5.11 --default; \
    chown app.app /usr/local/bundle -R

USER app
