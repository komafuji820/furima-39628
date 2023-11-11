class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
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

  def show
    find_item
  end

  def edit
    find_item
    if current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :explain, :price, :image, :category_id, :condition_id, :cost_id, :prefecture_id, :span_id).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
