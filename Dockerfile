FROM ruby:3.2.0-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      git \
      libmariadb-dev-compat \
      libmariadb-dev && \
    apt-get clean 

WORKDIR /usr/src

COPY Gemfile Gemfile.lock /usr/src/

RUN bundle install -j4

COPY . .

EXPOSE 3000
