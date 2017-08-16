# Protospace
プロトタイプを投稿するアプリケーションです

***

## Users table
|column|type|option|
|:-:|:-:|:-:|
|name|string|null: false, unique: true|
|email, password..etc||use gem 'devise'|
|avatar|text|use gem 'carrierwave', Amazon S3|
|profile|text||
|position|string||
|occupation|string||

### association
- has_many :protypes, :likes, :comments


## Prototypes table
|column|type|option|
|:-:|:-:|:-:|
|title|text|null: false|
|catch_copy|text||
|concept|text||
|user_id|integer|null: false, foreign_key: true|

### association
- belons_to :user
- has_many :captured_images, :likes, :comments

## CapturedImages table
|column|type|option|
|:-:|:-:|:-:|
|content|text|null: false, use gem 'carrierwave', Amazon S3|
|status|integer|null: false, default: 0, limit: 1|
|prototype_id|integer|null: false, foreign_key: true|

### association
- belons_to :prototype


## Likes table
|column|type|option|
|:-:|:-:|:-:|
|user_id|integer|null: false, foreign_key: true|
|prototype_id|integer|null: false, foreignkey: true|

### association
belongs_to :user, :prototype


## Comments table
|column|type|option|
|:-:|:-:|:-:|
|content|text|null: false|
|user_id|integer|foreign_key: true, null: false|
|prototype_id|integer|foreign_key: true, null: false|

### association
- belongs_to :user, :prototype


## Taggingss, Tags table
use gem 'acts-as-taggable-on'

***

# Setup
git cloneした後、以下のコマンドを実行してください
```sh
$ bundle install

$ rails db:create

$ rails db:migrate

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
