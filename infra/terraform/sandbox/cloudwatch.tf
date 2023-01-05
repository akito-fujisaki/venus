resource "aws_cloudwatch_log_group" "backend" {
  name = "/ecs/${local.app}-${local.env}-backend"

  retention_in_days = 1

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-backend"
  })
}
