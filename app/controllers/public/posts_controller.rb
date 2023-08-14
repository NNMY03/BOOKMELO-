class Public::PostsController < ApplicationController

  def new
    @posting = Post.new
  end
  
  def create
    @book = Book.find(params[:post][:book_id])
    @posting = @book.posts.new(post_params)
    @posting.customer_id = current_customer.id
   if @posting.save
    flash[:notice] = "ハッピーエンドをレビューしました"
    redirect_to book_path(@book.id)
   else
    @posts = Post.all
    render 'show'
   end
  end
  
  
  def index
    @posts = current_customer.posts.all
  end
  
  def show
    @posting = Post.find(params[:id])
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
    params.require(:post).permit(:reading_finish, :comment, :star, :memo, :book_id, :name, tag_ids:[])
  end

  
end
