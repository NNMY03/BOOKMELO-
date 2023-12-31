class Public::PostsController < ApplicationController
  before_action :ensure_customer, only: [:edit, :update, :destroy]

  def new
    @book = Book.find(params[:book_id])
    @posting = Post.new
  end

  def create
    @book = Book.find(params[:post][:book_id])
    @posting = @book.posts.new(post_params)
    @posting.customer_id = current_customer.id
    @posting.score = Language.get_data(post_params[:comment])
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
    @posts = current_customer.posts.order(created_at: :desc).page(params[:page])
    # [Fri, 18 Aug 2023, Sat, 19 Aug 2023, Thu, 10 Aug 2023, Fri, 18 Aug 2023, Thu, 17 Aug 2023, Wed, 16 Aug 2023]
    reading_finish = @posts.pluck(:reading_finish)
    # ["202308", "202308", "202308", "202308", "202308", "202308", "202307"]
    month_records = reading_finish.map { |rf| rf.strftime("%Y%m") }
    # {"202308"=>6, "202307"=>1}
    month_record = month_records.tally
    # 2
    # unless month_record.keys.count < 5
    #     # 3
    #     num = 5 - month_record.keys.count
    #     # [["202307", 1], ["202308", 6]]
    #     sorted_month_record = month_record.sort_by(&:first)
    #     # ["202307", 1]
    #     sorted_month_record_first = sorted_month_record.first
    #     # "202307"
    #     month = sorted_month_record_first.first
    #     # 3回まわす、nには0からindexがはじまる
    #     num.times do |n|
    #       n += 1
    #       # "202306"(１回目)
    #       mon = Date.strptime(month, "%Y%m").months_ago(n).strftime("%Y%m")
    #       # {"202308"=>6, "202307"=>1, "202306"=>0}(１回目)
    #       month_record[mon] = 0
    #     end
    # end

    month_record = month_record.sort_by(&:first)

    # 投稿日付の配列を格納。文字列を含んでいると正しく表示されないので.to_json.html_safeでjsonに変換。
    # => "[\"2023-08\"]"
    @chartlabels = month_record.map(&:first).to_json.html_safe

    # 日別投稿数の配列を格納。
    # => [6]
    @chartdatas = month_record.map(&:second)

    # お気に入り一覧
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:post_id)
    @favorite_list = Post.where(id: favorites).order(created_at: :desc)

    # メモ機能
    # 空のものを取得しない
    @postmemo = Post.where(customer_id: current_customer.id).where.not(memo: [nil, '']).order(created_at: :desc).page(params[:paage])

    # タグカウント数
    @excitement_count = Post.count_posts_with_tag(@posts, "＃感動した")
    @surprise_count = Post.count_posts_with_tag(@posts, "＃驚いた")
    @laugh_count = Post.count_posts_with_tag(@posts, "＃笑った")
    @fresh_count = Post.count_posts_with_tag(@posts, "＃爽快だった")
    @sad_count = Post.count_posts_with_tag(@posts, "＃切なくなった")
    @cry_count = Post.count_posts_with_tag(@posts, "＃泣いた")
  end

  def show
    @posting = Post.find(params[:id])
  end

 def edit
   @posting = Post.find(params[:id])
 end

  def update
      @posting = Post.find(params[:id])
    if @posting.update(post_params)
      @posting.score = Language.get_data(post_params[:comment])
      @posting.save
      flash[:notice] = "記録の編集が完了しました"
      redirect_to post_path(@posting)
    else
      render :edit
    end
  end


  private

  def ensure_customer
    @posts = current_customer.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end

  def post_params
    params.require(:post).permit(:reading_finish, :comment, :star, :memo, :book_id, :posted_status, :name, tag_ids:[])
  end

end
