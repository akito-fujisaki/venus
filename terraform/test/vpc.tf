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

resource "aws_eip" "ngw_a" {
  vpc = true

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-eip-ngw-a"
  })
}

# コストを抑えるためにNATは1つだけとする
resource "aws_nat_gateway" "ngw_a" {
  allocation_id = aws_eip.ngw_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-ngw-a"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-rt-public"
  })
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-rt-private"
  })
}

resource "aws_route" "private_ngw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw_a.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}
