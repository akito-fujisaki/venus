resource "aws_ecs_cluster" "backend" {
  name = "${local.app}-${local.env}-backend"

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-backend"
  })
}

resource "aws_ecs_cluster_capacity_providers" "backend" {
  cluster_name = aws_ecs_cluster.backend.name

  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_service" "backend_api" {
  name             = "api"
  cluster          = aws_ecs_cluster.backend.id
  task_definition  = aws_ecs_task_definition.dummy_backend_api.arn
  launch_type      = "FARGATE"
  propagate_tags   = "SERVICE"
  platform_version = "LATEST"

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_api.arn
    container_name   = "api"
    container_port   = 3000
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.backend.id]
    subnets          = data.aws_subnets.private.ids
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }

  depends_on = [aws_lb.main]

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-backend-api"
  })
}

resource "aws_ecs_task_definition" "dummy_backend_api" {
  family                   = "${local.app}-${local.env}-backend-api-dummy"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name  = "api"
      image = "alpine"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.backend.name,
          awslogs-region        = "ap-northeast-1",
          awslogs-stream-prefix = "dummy"
        }
      }
    }
  ])
}
