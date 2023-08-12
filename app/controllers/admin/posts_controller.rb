class Admin::PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if  @post.each do |post|
        unless Post.all.include?(post)
          post.save
          flash[:notice] = "ハッピーエンドをレビューしました"
          redirect_to admin_postspath
        end
      end
    end
  end
  
  def show
   @post = Post.find(params[:id])
  end

  def edit
   @post = Post.find(params[:id])
  end

  def update
   @post = Post.find(params[:id])
   if @post.update(customer_params)
     flash[:notice] = "情報を更新しました"
     redirect_to admin_customers_path
   else
     render :index
   end
  end

  private
    def customer_params
      params.require(:post).permit(:category)
    end

end
