data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${local.product}-${local.env}-subnet-public-*"]
  }
}

resource "aws_lb" "main" {
  name               = "${local.product}-${local.env}-elb-main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb.id]
  subnets            = data.aws_subnets.private.ids
  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-elb-main"
  })
}

resource "aws_lb_target_group" "backend" {
  name                          = "${local.product}-${local.env}-tg-backend"
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
    Name = "${local.product}-${local.env}-tg-backend"
  })
}

resource "aws_lb_listener" "backend_http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-lb-listener-backend-http"
  })
}
