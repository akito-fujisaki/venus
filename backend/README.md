# Venus-Backend

Railsを使用したBackend用ディレクトリ。

## MEMO

`rails`や`mysql2`をインストールするために、`build-essential`や`mariadb`系をインストールしておかないといけない

Railsをインストールしたdockerコンテナ内で、Railsアプリを作成する。

```
$ rails new . --minimal --api -d mysql
```
