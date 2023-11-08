require 'rails_helper'

RSpec.describe Item, type: :model do
  
  before do
    @item = FactoryBot.build(:item)
  end
  
  describe '商品新規出品' do
    context '商品が出品できるとき' do
      it 'name,explain,price,category_id,condition_id,cost_id,prefecture_id,span_id,ユーザー,imageがあれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では出品できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      
      it 'explainが空では出品できない' do
        @item.explain = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end

      it 'priceが空では出品できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300円未満では出品できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが10,000,000円以上では出品できない' do
        @item.price = Faker::Number.number(digits: 8)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'priceが全角では出品できない' do
        @item.price = '30０'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'priceが数値以外では出品できない' do
        @item.price = Faker::Lorem.characters(number: 7, min_alpha: 1, min_numeric: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      
      it 'category_idが未入力(id:1)では出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが未入力(id:1)では出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'cost_idが未入力(id:1)では出品できない' do
        @item.cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end

      it 'prefecture_idが未入力(id:1)では出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'span_idが未入力(id:1)では出品できない' do
        @item.span_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Span can't be blank")
      end
  
      it 'ユーザーが紐づいていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

    end
  end
end