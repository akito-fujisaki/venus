#!/bin/bash

set -eu

TASK_DEFINITION=$1
APP_NAME=$2
DEPROY_ENV=$3
export IMAGE_URI=$4

export TASK_ROLE_ARN=$(aws iam get-role --role-name ${APP_NAME}-${DEPROY_ENV}-ecs-task-role | jq -r '.Role.Arn')
export TASK_EXECUTION_ROLE_ARN=$(aws iam get-role --role-name ${APP_NAME}-${DEPROY_ENV}-ecs-task-role | jq -r '.Role.Arn')
export SECRETS_MANAGER_ARN=$(aws secretsmanager list-secrets --filter Key=name,Values=${APP_NAME}-${DEPROY_ENV}| jq -r '.SecretList[0].ARN')

cd $(dirname $0)
envsubst < ../task_definitions/${TASK_DEFINITION}.json
