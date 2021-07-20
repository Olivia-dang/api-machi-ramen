class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /items
  def index
    @items = Item.all 
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    @item.user_id = 1
    authorize @item

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    authorize @item
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    authorize @item
    @item.destroy
  end

  def edit
  end

  private
  def item_params
    params.require(:item).permit(:category_id, :name, :price, :description)
  end
  def set_item
    @item = Item.find(params[:id])
  end

  def user_not_authorized
    render json: {
      status: 401,
      message: "You are not authorized to perform this action."
    }, status: :unauthorized
  end
end
