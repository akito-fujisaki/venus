resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-vpc"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-igw"
  })
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "ap-northeast-1a"

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-subnet-public-a"
  })
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "ap-northeast-1c"

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-subnet-public-c"
  })
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.64.0/20"
  availability_zone = "ap-northeast-1a"

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-subnet-private-a"
  })
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.80.0/20"
  availability_zone = "ap-northeast-1c"

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-subnet-private-c"
  })
}
