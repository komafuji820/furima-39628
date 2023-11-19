class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    end
  end

  private

  def purchase_params
    params.permit(:item_id).merge(user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @purchase.item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

end
