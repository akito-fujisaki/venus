resource "aws_db_parameter_group" "main" {
  name        = "${local.app}-${local.env}"
  description = "${local.app}-${local.env}"
  family      = "mysql8.0"

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}"
  })
}

resource "aws_db_option_group" "main" {
  name                     = "${local.app}-${local.env}"
  option_group_description = "${local.app}-${local.env}"
  engine_name              = "mysql"
  major_engine_version     = "8.0"

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}"
  })
}

resource "aws_db_subnet_group" "main" {
  name        = "${local.app}-${local.env}"
  description = "${local.app}-${local.env}"
  subnet_ids  = data.aws_subnets.private.ids

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}"
  })
}

# sandboxなのでマルチAZ配置、暗号化、バックアップ等は行わない
resource "aws_db_instance" "main" {
  allocated_storage                     = 20
  auto_minor_version_upgrade            = true
  availability_zone                     = "ap-northeast-1a"
  backup_retention_period               = 0
  backup_window                         = "13:35-14:05"
  copy_tags_to_snapshot                 = true
  customer_owned_ip_enabled             = false
  db_subnet_group_name                  = aws_db_subnet_group.main.name
  delete_automated_backups              = true
  deletion_protection                   = false
  enabled_cloudwatch_logs_exports       = []
  engine                                = "mysql"
  engine_version                        = "8.0"
  iam_database_authentication_enabled   = true
  identifier                            = "${local.app}-${local.env}"
  instance_class                        = "db.t3.micro"
  iops                                  = 0
  license_model                         = "general-public-license"
  maintenance_window                    = "tue:18:00-tue:18:30"
  max_allocated_storage                 = 0
  monitoring_interval                   = 0
  multi_az                              = false
  network_type                          = "IPV4"
  option_group_name                     = aws_db_option_group.main.name
  parameter_group_name                  = aws_db_parameter_group.main.name
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  port                                  = 3306
  publicly_accessible                   = false
  skip_final_snapshot                   = true
  storage_encrypted                     = false
  storage_type                          = "gp2"
  username                              = "root"
  password                              = random_password.database_root_user.result
  vpc_security_group_ids                = [aws_security_group.rds.id]

  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}"
  })
}
