class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipalities, :house_number, :house_name, :phone_number, :token

  with_options presence: true do
    validates :post_code, :municipalities, :house_number, :phone_number, :token, :user_id, :item_id
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, house_number: house_number, house_name: house_name, phone_number: phone_number, purchase_id: purchase.id)
  end

end