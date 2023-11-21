class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipalities, :house_number, :house_name, :phone_number, :token

  with_options presence: true do
    validates :municipalities, :house_number, :token, :user_id, :item_id
    validates :post_code, format: {with: /\A\d{3}-\d{4}\z/}
    validates :phone_number, format: {with: /\A\d{10,11}\z/}
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, house_number: house_number, house_name: house_name, phone_number: phone_number, purchase_id: purchase.id)
  end

end