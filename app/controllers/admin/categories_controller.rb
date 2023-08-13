class Admin::CategoriesController < ApplicationController

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.find(params[:id])
    if  @category.each do |post|
        unless Category.all.include?(category)
          category.save
          flash[:notice] = "追加しました"
          redirect_to admin_categories_path
        end
      end
    end
  end

#   def show
#   @category = Category.find(params[:id])
#   end

  def edit
   @category = Category.find(params[:id])
  end

  def update
   @category = Category.find(params[:id])
   if @category.update(category_params)
     flash[:notice] = "情報を更新しました"
     redirect_to admin_categories_path
   else
     render :index
   end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

end
