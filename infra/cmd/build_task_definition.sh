#!/bin/bash -eu

export IMAGE_URI=$1
APP_NAME=$2
DEPROY_ENV=$3
TASK_DEFINITION=$4

export TASK_ROLE_ARN=$(aws iam get-role--role-name ${APP_NAME}-${DEPROY_ENV}-ecs-task-role | jq -r '.Role.Arn')
export TASK_EXECUTION_ROLE_ARN=$(aws iam get-role--role-name ${APP_NAME}-${DEPROY_ENV}-ecs-task-role | jq -r '.Role.Arn')
export SECRETS_MANAGER_ARN=$(aws secretsmanager list-secrets --filter Key=name,Values=${APP_NAME}-${DEPROY_ENV}| jq -r '.SecretList[0].ARN')

echo $(envsubst < ../task_definitions/${TASK_DEFINITION}.json)
