# シークレットを削除すると同じ名前でしばらく作成できないため、回避策としてランダムな文字列を末尾に加える
resource "aws_secretsmanager_secret" "main" {
  name = "${local.product}-${local.env}-${random_id.main.hex}"
  tags = merge(local.default_tags, {
    Name = "${local.product}-${local.env}-${random_id.main.hex}"
  })
}
