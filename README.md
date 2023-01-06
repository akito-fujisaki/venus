# Venus

Railsとインフラの勉強用のリポジトリ

terraformで使用するため、ルートディレクトリに`.env`ファイルを作成し下記のような形で記述する。

```
TF_VAR_github_repository_name=akito-fujisaki/venus
```

## ECSタスクを単体で実行

下記はマイグレーションを実行する例
```
# cmd/ecs-run-backend <環境名> <コマンド>
$ cmd/ecs-run-backend sandbox rails db:migrate
```

## ECSタスクコンテナへ入る

下記は`sandbox`用のECSタスクに入る例
```
# cmd/ecs-exec-backend <環境名> <コマンド>
$ cmd/ecs-exec-backend sandbox bash
```
