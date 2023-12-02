class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :span
  has_one_attached :image
  has_one :purchase

  validates :name, :explain, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, only_integer: true }
  validates :category_id, :condition_id, :cost_id, :prefecture_id, :span_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :image, presence: true

end
