# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| ruby_last_name     | string  | null: false               |
| ruby_first_name    | string  | null: false               |
| birthday           | date    | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| explain        | text       | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |
| category_id    | integer    | null: false                    |
| condition_id   | integer    | null: false                    |
| cost_id        | integer    | null: false                    |
| prefecture_id  | integer    | null: false                    |
| span_id        | integer    | null: false                    |


### Association

- has_one :purchase
- belongs_to :user
- belongs_to :category
- belongs_to :condition
- belongs_to :cost
- belongs_to :prefecture
- belongs_to :span


## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| post_code      | string     | null: false                    |
| municipalities | string     | null: false                    |
| house_number   | string     | null: false                    |
| house_name     | string     |                                |
| phone_number   | string     | null: false                    |
| purchase       | references | null: false, foreign_key: true |
| prefecture_id  | integer    | null: false                    |

### Association

- belongs_to :purchase
- belongs_to :prefecture