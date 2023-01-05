resource "aws_lb" "backend" {
  name               = "${local.app}-${local.env}-backend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb.id]
  subnets            = data.aws_subnets.public.ids

  depends_on = [aws_security_group.elb]

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-backend"
  })
}

resource "aws_lb_target_group" "backend_api" {
  name                          = "${local.app}-${local.env}-backend-api"
  port                          = 3000
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.main.id
  target_type                   = "ip"
  deregistration_delay          = 30
  load_balancing_algorithm_type = "least_outstanding_requests"

  health_check {
    interval            = 60
    path                = "/healthcheck"
    protocol            = "HTTP"
    timeout             = 30
    unhealthy_threshold = 4
    matcher             = 200
  }

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-backend-api"
  })
}

resource "aws_lb_listener" "backend_api_http" {
  load_balancer_arn = aws_lb.backend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_api.arn
  }

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-backend-api-http"
  })
}
