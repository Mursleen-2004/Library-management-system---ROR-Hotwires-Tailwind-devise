class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.alphabetical.page(params[:page]).per(12)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: "Category was successfully deleted.", status: :see_other
    else
      redirect_to categories_path, alert: @category.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
