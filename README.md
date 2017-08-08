# Protospace
Post prototypes.

# DB

## Users
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


## Prototypes
|column|type|option|
|:-:|:-:|:-:|
|title|text|null: false|
|catch_copy|text||
|concept|text||
|user_id|integer|null: false, foreign_key: true|

### association
- belons_to :user
- has_many :captured_images, :likes, :comments

## CapturedImages
|column|type|option|
|:-:|:-:|:-:|
|content|text|null: false, use gem 'carrierwave', Amazon S3|
|status|integer|null: false, default: 0, limit: 1|
|prototype_id|integer|null: false, foreign_key: true|

### association
- belons_to :prototype


## Likes
|column|type|option|
|:-:|:-:|:-:|
|user_id|integer|null: false, foreign_key: true|
|prototype_id|integer|null: false, foreignkey: true|

### association
belongs_to :user, :prototype


## Comments
|column|type|option|
|:-:|:-:|:-:|
|content|text|null: false|
|user_id|integer|foreign_key: true, null: false|
|prototype_id|integer|foreign_key: true, null: false|

### association
- belongs_to :user, :prototype


## Taggingss, Tags
use gem 'acts-as-taggable-on'
