FROM ruby:3.3.1 AS base

RUN useradd -u 1000 app; \
    mkdir -p /home/app/app; \
    chown app.app -R /home/app

WORKDIR /home/app/app

COPY --chown=app:app Gemfile* /home/app/app/

RUN gem update --system; \
    gem install bundler:2.5.16 --default; \
    bundle install ; \
    chown app.app /usr/local/bundle -R

USER app
