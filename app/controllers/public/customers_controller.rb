class Public::CustomersController < ApplicationController
  before_action :set_post, only: [:show]

  def show
    @customer = current_customer
    @posts = @customer.posts
    # @comments = @customer.posts.pluck(:comment).compact
    # @customer.posts # ログインユーザーに紐づくPost一覧を取得
    # pluck(:comment) # Post一覧からcommentだけ抜き出す [comment1, comment2, '', '', COMMENT3]
    # compact # 空の情報を削除する
    @posts_latest3 = @posts.first(2)

    # 月別集計
    # 本番環境のみの処理
    if Rails.env.production?
    @month_record = @posts.group("date_format(posts.reading_finish, '%Y%m')").count #2023/03/25
    # 開発環境のみの処理
    elsif Rails.env.development?
    @month_record = @posts.group("strftime('%Y%m',posts.reading_finish)").count #2023/03/25
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "登録情報を更新しました"
      redirect_to customer_path
    else
      render "edit"
    end
  end

  def confirm_withdraw
  end

  def withdraw
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

 private

# ユーザー投稿データを取得
def set_post
  @posts = current_customer.posts.all.order(created_at: :desc)
end

  def customer_params
    params.require(:customer).permit(:name, :email, :age, :is_deleted, :gender, :introduction, :image, :comment, :memo)
  end


end
