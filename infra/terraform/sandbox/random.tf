# シークレットを削除すると同じ名前でしばらく作成できないため、回避策としてランダムな文字列を末尾に加えるための使用する
resource "random_id" "main" {
  byte_length = 4
}

resource "random_id" "rails_secret_key_base" {
  byte_length = 64
}

resource "random_password" "database_root_user" {
  length  = 8
  special = false
}
