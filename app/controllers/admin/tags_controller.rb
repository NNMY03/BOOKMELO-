class Admin::TagsController < ApplicationController

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
        flash[:notice] = "追加しました"
        redirect_to admin_tags_path
    else
        @tags = Tag.all
        render 'index'
    end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_path
  end


  def show
  @tag = tag.find(params[:id])
  end

  def edit
   @tag = Tag.find(params[:id])
  end

  def update
   @tag = Tag.find(params[:id])
   if @tag.update(tag_params)
     flash[:notice] = "情報を更新しました"
     redirect_to admin_tags_path
   else
     render :index
   end
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end

end
