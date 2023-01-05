resource "aws_secretsmanager_secret" "main" {
  name = "${local.app}-${local.env}-${random_id.main.hex}"
  tags = merge(local.default_tags, {
    Name = "${local.app}-${local.env}-${random_id.main.hex}"
  })
}

# sandbox環境のためterraformで設定しているが、それ以外の環境ではマネジメントコンソール等で設定すること
resource "aws_secretsmanager_secret_version" "main" {
  secret_id = aws_secretsmanager_secret.main.id
  secret_string = jsonencode({
    DATABASE_URL    = "mysql2://root:${random_password.database_root_user.result}@${aws_db_instance.main.endpoint}/venus",
    SECRET_KEY_BASE = random_id.rails_secret_key_base.hex
  })
}
