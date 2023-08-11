class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @book = Book.find(params[:id])
  end
  
  def create
  end
  
  def index
  end

  def show
    @post = Post.new
    @book = Book.find(params[:id])

  end

  def edit
  end
  
  def update
  end
  
  def favorites
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :comment, :star, :latest, :category)
  end

  
end
