require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品が購入できるとき' do
      it 'すべてを正しく入力すれば商品を購入できる' do
        expect(@purchase_address).to be_valid
      end

      it 'house_nameが空でも商品を購入できる' do
        @purchase_address.house_name = ""
        expect(@purchase_address).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it 'post_codeが空では購入できない' do
        @purchase_address.post_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end

      it 'post_codeが全角では購入できない' do
        @purchase_address.post_code = "123-456７"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'post_codeにハイフンがなければ購入できない' do
        @purchase_address.post_code = Faker::Number.number(digits: 7)
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'prefectureが空(id=1)では購入できない' do
        @purchase_address.prefecture_id = "1"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'municipalitiesが空では購入できない' do
        @purchase_address.municipalities = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'house_numberが空では購入できない' do
        @purchase_address.house_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では購入できない' do
        @purchase_address.phone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end

      it 'phone_numberが全角では購入できない' do
        @purchase_address.phone_number = "0901234567８"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberが10桁未満では購入できない' do
        @purchase_address.phone_number = Faker::Number.number(digits: 9)
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberが12桁以上では購入できない' do
        @purchase_address.phone_number = Faker::Number.number(digits: 12)
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberにハイフンがあるときは購入できない' do
        @purchase_address.phone_number = "090-1234-5678"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'tokenが空では購入できない' do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

      it '購入するユーザーが紐づいていなければ購入できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Userを入力してください")
      end

      it '出品された商品が紐づいていなければ購入できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Itemを入力してください")
      end
      
    end
  end
end