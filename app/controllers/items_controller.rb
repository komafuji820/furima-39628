class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :explain, :price, :image, :category_id, :condition_id, :cost_id, :prefecture_id, :span_id).merge(user_id: current_user.id)
  end
end
