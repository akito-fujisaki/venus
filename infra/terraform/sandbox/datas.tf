data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.app}-${local.env}-subnet-public-*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${local.app}-${local.env}-subnet-private-*"]
  }
}
