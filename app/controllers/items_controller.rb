class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy]
  def index
    @items = Item.all 
    render json: @items
  end
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @item.destroy
  end

  
  private
  def item_params
    params.require(:item).permit(:category_id, :name, :price, :description)
  end
  def set_item
    @item = Item.find(params[:id])
  end
end
