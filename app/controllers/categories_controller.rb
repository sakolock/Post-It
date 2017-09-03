# Create a new category model-backed form
#  - with validations.
# You'll need to:
#  - add a route
#  - create controller/actions 
#  - create view templates.

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_user, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} successfully created."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def set_category
    @category = Category.find_by slug: params[:id]
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
