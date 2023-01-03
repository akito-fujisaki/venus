resource "aws_ecs_cluster" "main" {
  name = "${local.product}-${local.env}"

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}"
  })
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = ["FARGATE"]
}
