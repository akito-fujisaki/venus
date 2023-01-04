#!/bin/bash -eu

APP_NAME=$1
DEPROY_ENV=$2
ECR_REGISTRY=$3
TEMPLATE_TASK_DEFINITION_PATH=$4

export IMAGE_URI=${ECR_REGISTRY}/venus-backend:$(git rev-parse main)
export TASK_ROLE_ARN=$(aws iam get-role--role-name ${APP_NAME}-${DEPROY_ENV}-ecs-task-role | jq -r '.Role.Arn')
export TASK_EXECUTION_ROLE_ARN=$(aws iam get-role--role-name ${APP_NAME}-${DEPROY_ENV}-ecs-task-role | jq -r '.Role.Arn')
export SECRETS_MANAGER_ARN=$(aws secretsmanager list-secrets --filter Key=name,Values=${APP_NAME}-${DEPROY_ENV}| jq -r '.SecretList[0].ARN')

envsubst < TEMPLATE_TASK_DEFINITION_PATH
