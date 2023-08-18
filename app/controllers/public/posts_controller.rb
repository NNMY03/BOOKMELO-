class Public::PostsController < ApplicationController

   def edit
    @posting = Post.find(params[:id])
   end

  def update
      @posting = Post.find(params[:id])
    if @posting.update(post_params)
      flash[:notice] = "記録の編集が完了しました"
      redirect_to post_path(@posting)
    else
      render :edit
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @posting = Post.new
  end

  def create
    @book = Book.find(params[:post][:book_id])
    @posting = @book.posts.new(post_params)
    @posting.customer_id = current_customer.id
   if @posting.save
    flash[:notice] = "ハッピーエンドをレビューしました"
    redirect_to post_path(@posting)
   else
    render 'new'
   end
  end

  def destroy
    @posting = Post.find(params[:id])
    @posting.destroy
    redirect_to posts_path
  end


  def index
    @posts = current_customer.posts.posted_status.page(params[:page])
  end

  def show
    @posting = Post.find(params[:id])
  end
  
  private

  def post_params
    params.require(:post).permit(:reading_finish, :comment, :star, :memo, :book_id, :posted_status, :name, tag_ids:[])
  end


end
