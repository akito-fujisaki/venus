resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
}

resource "aws_security_group" "elb" {
  description            = "${local.app}-${local.env}-sg-elb"
  name                   = "${local.app}-${local.env}-sg-elb"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-sg-elb"
  })
}

resource "aws_security_group_rule" "elb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "elb_ingress_http" {
  type              = "ingress"
  description       = "allow http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "elb_ingress_https" {
  type              = "ingress"
  description       = "allow https"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group" "backend" {
  description            = "${local.app}-${local.env}-sg-backend"
  name                   = "${local.app}-${local.env}-sg-backend"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-sg-backend"
  })
}

resource "aws_security_group_rule" "backend_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.backend.id
}

resource "aws_security_group_rule" "backend_ingress_3000" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.backend.id
}

resource "aws_security_group" "rds" {
  description            = "${local.app}-${local.env}-sg-rds"
  name                   = "${local.app}-${local.env}-sg-rds"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-sg-rds"
  })
}

resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.rds.id
}
