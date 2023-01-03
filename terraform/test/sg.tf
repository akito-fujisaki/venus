resource "aws_security_group" "elb" {
  description            = "${local.product}-${local.env}-sg-elb"
  name                   = "${local.product}-${local.env}-sg-elb"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-sg-elb"
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
  description            = "${local.product}-${local.env}-sg-backend"
  name                   = "${local.product}-${local.env}-sg-backend"
  vpc_id                 = aws_vpc.main.id
  revoke_rules_on_delete = false

  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-sg-backend"
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
