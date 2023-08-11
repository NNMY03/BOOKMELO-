class Public::PostsController < ApplicationController

  def index
  end

  def show
    @book = Book.find(params[:id])
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "ハッピーエンドをレビューしました"
      redirect_to post_path(@poat.id)
    else
      @posts = Post.all
      render 'Show'
    end

  end

  def edit
  end
  
  def update
  end
  
  def favorites
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :comment, :star, :latest, :category, :memo)
  end

  
end
