# Venus-Infra

インフラ用ディレクトリ。

terraformを使用してインフラの構築を行う。
なお、importコマンドを使用してtfstateを確認しながら作業をしたいため、tfstateはローカルで管理している。

## 作業方法

プロジェクトルートで下記コマンドを実行し、コンテナへ入る。

```
$ docker-compose run --rm infra bash
```

コンテナ内でディレクトリへ移動し、各種terraformコマンドを実行すること。

```
$ cd terraform/sandbox

$ terraform init
$ terraform fmt
$ terraform plan
$ terraform apply
```
