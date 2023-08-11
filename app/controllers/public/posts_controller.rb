class Public::PostsController < ApplicationController

  def create
  end
  
  def index
  end

  def show
    @book = Book.find(params[:id])
    @post = Post.new
    @posts = Post.all
    

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
