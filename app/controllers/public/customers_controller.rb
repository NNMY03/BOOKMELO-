class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer

    @posts = @customer.posts.limit(3).order(" created_at DESC ")
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    # @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "登録情報を更新しました"
      redirect_to customers_information_path
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

  def customer_params
    params.require(:customer).permit(:name, :email, :age, :is_deleted, :gender, :introduction, :image)
  end

  
end
