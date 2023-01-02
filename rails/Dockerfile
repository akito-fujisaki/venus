FROM ruby:3.2.0-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      git \
      libmariadb-dev-compat \
      libmariadb-dev && \
    apt-get clean

WORKDIR /app

COPY Gemfile Gemfile.lock /app

RUN bundle install -j4

COPY . .

EXPOSE 3000
