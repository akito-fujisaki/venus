# Venus

Railsとインフラの勉強用のリポジトリ

## ECSタスクを単体で実行

```
$ cmd/ecs-run-backend <環境名> <コマンド>
```

下記はマイグレーションを実行する例
```
$ cmd/ecs-run-backend sandbox rails db:migrate
```

## ECSタスクコンテナへの入り方

```
$ cmd/ecs-sh-backend <環境名> <コマンド>
```

下記は`sandbox`用のECSタスクに入る例

```
$ cmd/ecs-sh-backend sandbox bash
```
