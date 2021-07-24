class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /items
  def index
    @items = Item.all 
    items_array = MenuSerializer.new(@items)
    render json: items_array.serialize_new_items()
  end

  # GET /items/1
  def show
    item_serializer = ItemSerializer.new(item: @item)
    render json: item_serializer.serialize_new_item()
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    @item.user_id = 1
    authorize @item

    if @item.save
      item_serializer = ItemSerializer.new(item: @item)
      render json: item_serializer.serialize_new_item() , status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    authorize @item
    if @item.update(item_params)
      item_serializer = ItemSerializer.new(item: @item)
      render json: item_serializer.serialize_new_item()
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    authorize @item
    @item.destroy
  end

  private
  # returning only the permitted keys and values
  def item_params
    # params.require(:item).permit(:category_id, :name, :price, :description)
    params.permit(:category_id, :name, :price, :description, :image)
  end

  # Find the item with id from params
  def set_item
    @item = Item.find(params[:id])
  end
  
  # rescue from unauthorized error
  def user_not_authorized
    render json: {
      status: 401,
      message: "You are not authorized to perform this action with items."
    }, status: :unauthorized
  end
end
