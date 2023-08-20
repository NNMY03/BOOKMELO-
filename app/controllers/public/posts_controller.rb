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
    @posts = current_customer.posts.posted_status.order(created_at: :desc).page(params[:page])

    # お気に入り一覧
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:post_id)
    @favorite_list = Post.where(id: favorites)

    # メモ機能
    # 空のものを取得しない
    @postmemo = Post.where(customer_id: current_customer.id).where.not(memo: [nil, ''])
    
    # タグカウント数
    # @post_count = @posts.tag.pluck(:name).compact
    # @excitement_count = @posts.tap.where(name: "＃感動した").count
    # @surprise_count = Tag.where(name: "＃驚いた").count
    # @laugh_count = Tag.where(name: "＃笑った").count
    # @fresh_count = Tag.where(name: "＃爽快だった").count
    # @sad_count = Tag.where(name: "＃切なくなった").count
    # @cry_count = Tag.where(name: "＃泣いた").count

    # @post_count = Tag.joins(:name).group("tags.name").order('count_all DESC').count


    # 月別集計
    # 本番環境のみの処理
    if Rails.env.production?
    @month_record = @posts.group("date_format(posts.reading_finish, '%Y%m')").count #2023/03/25
    # 開発環境のみの処理
    elsif Rails.env.development?
    @month_record = @posts.group("strftime('%Y%m',posts.reading_finish)").count #2023/03/25
    end
  end

  def show
    @posting = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:reading_finish, :comment, :star, :memo, :book_id, :posted_status, :name, tag_ids:[])
  end


end
