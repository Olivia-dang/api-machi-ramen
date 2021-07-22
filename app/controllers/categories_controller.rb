class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /categories
  def index
    @categories = Category.all 
    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    authorize @category
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    authorize @category
    @category.destroy
  end

  
  private
  # returning only the permitted keys and values
  def category_params
    params.require(:category).permit(:name)
  end

  # Find the category with id from params
  def set_category
    @category = Category.find(params[:id])
  end

  # rescue from unauthorized error
  def user_not_authorized
    render json: {
      status: 401,
      message: "You are not authorized to perform this action with category."
    }, status: :unauthorized
  end
end
