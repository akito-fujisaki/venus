FROM debian:bullseye-slim

WORKDIR /tmp

# AWS CLIv2: https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html
# Terrafrom: https://developer.hashicorp.com/terraform/downloads
ENV AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" \
    TERRAFORM_URL="https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_arm64.zip"

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
