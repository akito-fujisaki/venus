resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${local.product}-${local.env}-ecs-task-execution-role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = ""
          Effect = "Allow"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
          Action = "sts:AssumeRole"
        }
      ]
  })

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-ecs-task-execution-role"
  })
}

data "aws_iam_policy" "amazon_ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "secrets_manager_read" {
  description = "${local.product}-${local.env}-secrets-manager-read"
  name        = "${local.product}-${local.env}-secrets-manager-read"
  path        = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
        ]
        Effect   = "Allow"
        Resource = aws_secretsmanager_secret.main.arn
      }
    ]
  })
  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-secrets-manager-read"
  })
}

resource "aws_iam_role_policy_attachment" "amazon_ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = data.aws_iam_policy.amazon_ecs_task_execution_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "secrets_manager_read" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.secrets_manager_read.arn
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${local.product}-${local.env}-ecs-task-role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = ""
          Effect = "Allow"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
          Action = "sts:AssumeRole"
        }
      ]
  })

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-ecs-task-role"
  })
}
