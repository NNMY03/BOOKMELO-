class Public::CustomersController < ApplicationController
  before_action :set_post, only: [:show]

  def show
    @customer = current_customer
    @posts = @customer.posts
    @comments = @customer.posts.pluck(:comment).compact
    # @customer.posts # ログインユーザーに紐づくPost一覧を取得
    # pluck(:comment) # Post一覧からcommentだけ抜き出す [comment1, comment2, '', '', COMMENT3]
    # compact # 空の情報を削除する
    @posts_latest3 = @posts.first(3)
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
  @posts = current_customer.posts.all
end

  def customer_params
    params.require(:customer).permit(:name, :email, :age, :is_deleted, :gender, :introduction, :image, :comment, :memo)
  end


end
