# Venus-Terraform

Terraform用ディレクトリ。

なお、importコマンドを使用してtfstateを確認しながら作業をしたいため、tfstateはローカルで管理している。

test環境は必要なときに作成し、タグをつけてpushすることでGithubActionsでデプロイできるようにすることを想定している。

- common: 共有で使用するリソース用ディレクトリ
- test: テスト環境用ディレクトリ

## 作業方法

プロジェクトルートで下記コマンドを実行し、コンテナへ入る。

```
$ docker-compose run --rm terraform ash
```

コンテナ内でディレクトリへ移動し、各種terraformコマンドを実行すること。

```
$ cd test

$ terraform init
$ terraform fmt
$ terraform plan
$ terraform apply
```
