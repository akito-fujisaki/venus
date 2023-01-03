resource "aws_secretsmanager_secret" "main" {
  name = "${local.product}-${local.env}"
  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-secretsmanager"
  })
}
