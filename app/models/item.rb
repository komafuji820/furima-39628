class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :span
  has_one_attached :image

  validates :name, :explain, presence: true
  validates :price, numericality: { in: (300..9999999), only_integer: true, message: "can't be blank" }
  validates :category_id, :condition_id, :cost_id, :prefecture_id, :span_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :image, presence: true

end
