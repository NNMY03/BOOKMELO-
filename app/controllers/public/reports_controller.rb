class Public::ReportsController < ApplicationController
  before_action :ensure_customer, only: [:edit, :update, :destroy]
  
  def new
   @report = Report.new
   @post = Post.find(params[:post_id])
  end
  
  def create
    @post = Post.find(params[:post_id])
    @report = Report.new(report_params)
    @report.customer_id = current_customer.id
    @report.post_id = @post.id     #通報者(reporter_id)にcurrent_user.idを代入
    if @report.save
      redirect_to post_path(@post), notice: "ご報告ありがとうございます。"
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :customer_id, :post_id, :img_big, :author, :publisher, :item_caption)
  end
end

