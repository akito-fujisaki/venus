resource "aws_cloudwatch_log_group" "main" {
  name = "/ecs/${local.product}-${local.env}"

  retention_in_days = 1

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}"
  })
}
