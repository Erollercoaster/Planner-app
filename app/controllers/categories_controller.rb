class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy, :edit]

  def index
    @categories = current_user.categories.all
  end

  def show; end

  def new; end
  
  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to category_path(@category), notice: 'Category was successfully created.'
    else
      flash.now[:alert] = 'There were problems creating the category.'
      render turbo_stream: turbo_stream.replace('category-modal-form', partial: 'categories/category_form', locals: { category: @category })
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'There were problems updating the category.'
      render turbo_stream: turbo_stream.replace('category-modal-form', partial: 'categories/category_form', locals: { category: @category })
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
