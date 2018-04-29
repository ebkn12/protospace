# Protospace

プロトタイプを投稿するアプリケーションです

#### dependencies
- ruby 2.5.1
- rails 5.2.0
- mysql

# Setup

```sh
$ bundle install

$ rails db:setup

$ rails s
```

画像を投稿するには、Amazon S3にアクセスするキーが必要です。
.env.sampleを参考にして、.envファイルを作成してください

```ruby
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
AWS_S3_BUCKET
```

# Set sample data
ユーザーやプロトタイプのサンプルデータを入れるには、以下のコマンドを実行してください
```sh
$ rails db:seed
```
(画像のサンプルデータはセットしません)

# Test
テストを実行するには、以下のコマンドを実行してください
```sh
$ rspec
```
