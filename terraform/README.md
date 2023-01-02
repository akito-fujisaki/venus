# Venus-Terraform

Terraform用ディレクトリ。

なお、importコマンドを使用してtfstateを確認しながら作業をしたいため、tfstateはローカルで管理している。

- common: 共有で使用するリソース用ディレクトリ
- staging: ステージング環境用ディレクトリ
- production: 本番環境用ディレクトリ

## 作業方法

プロジェクトルートで下記コマンドを実行し、コンテナへ入る。

```
$ docker-compose run --rm terraform ash
```

コンテナ内でディレクトリへ移動し、各種terraformコマンドを実行すること。

```
$ cd staging

$ terraform init
$ terraform fmt
$ terraform plan
$ terraform apply
```
