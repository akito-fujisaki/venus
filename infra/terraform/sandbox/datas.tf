data "aws_subnets" "public" {
  filter {
    name = "subnet-id"
    values = [
      aws_subnet.public_a.id,
      aws_subnet.public_c.id
    ]
  }
}

data "aws_subnets" "private" {
  filter {
    name = "subnet-id"
    values = [
      aws_subnet.private_a.id,
      aws_subnet.private_c.id
    ]
  }
}
