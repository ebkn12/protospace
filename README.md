# Database

## User
|column|type|option|
|:-:|:-:|:-:|
|name|string|null: false, unique: true|
|email||use 'devise'|
|password||use 'devise'|
|avatar|text||
|profile|text||
|position|string||
|occupation|string||

### association
- has_many :protypes, :likes, :comments


## Prototype
|column|type|option|
|:-:|:-:|:-:|
|title|text|null: false|
|catch_copy|text||
|concept|text||
|user_id|integer|null: false, foreign_key: true|

### association
- belons_to :user
- has_many :captured_images, :likes, :comments

## CapturedImage
|column|type|option|
|:-:|:-:|:-:|
|content|text|null: false|
|status|integer|null: false, default: 0, limit: 1|
|prototype_id|integer|null: false, foreign_key: true|

### association
- belons_to :prototype


## Like
|column|type|option|
|:-:|:-:|:-:|
|user_id|integer|null: false, foreign_key: true|
|prototype_id|integer|null: false, foreignkey: true|

### association
belongs_to :user, :prototype


## Comment
|column|type|option|
|:-:|:-:|:-:|
|content|text|null: false|
|user_id|integer|foreign_key: true, null: false|
|prototype_id|integer|foreign_key: true, null: false|

### association
- belongs_to :user, :prototype
