data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.product}-${local.env}-subnet-public-*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${local.product}-${local.env}-subnet-private-*"]
  }
}
