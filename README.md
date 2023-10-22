# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| ruby_last_name     | string  | null: false |
| ruby_first_name    | string  | null: false |
| birthday           | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| explain        | text       | null: false                    |
| category       | string     | null: false                    |
| condition      | string     | null: false                    |
| shipping_cost  | string     | null: false                    |
| address        | string     | null: false                    |
| shipping_days  | string     | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- has_one :purchase
- belongs_to :user

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
| post_code      | integer    | null: false                    |
| prefecture     | string     | null: false                    |
| municipalities | string     | null: false                    |
| house_number   | string     | null: false                    |
| house_name     | string     |                                |
| phone_number   | integer    | null: false                    |
| purchase       | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase