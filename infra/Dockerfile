FROM debian:bullseye-slim

WORKDIR /tmp

ARG AWS_CLI_URL
ARG TERRAFORM_URL

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates=20210119 \
      git \
      less \
      curl \
      jq \
      unzip && \
    apt-get clean

RUN curl -fL $AWS_CLI_URL -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf ./awscliv2.zip

RUN curl -fL $TERRAFORM_URL -o terraform.zip && \
    unzip terraform.zip -d /usr/local/bin && \
    rm -rf terraform.zip

WORKDIR /infra
