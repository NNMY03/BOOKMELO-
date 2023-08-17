class Public::ReportsController < ApplicationController
  
  def new
   @report = Report.new
   @book = Book.find(params[:book_id])
  end
  
  def create
    @book = Book.find(params[:book_id])
    @report = Report.new(report_params)
    @report.customer_id = current_customer.id  #通報者(reporter_id)にcurrent_user.idを代入
    # @report.post_id_id = @book.id　　#通報される人(reported_id)に上で取得した@user.idを代入
    if @report.save
      redirect_to book_path(@book), notice: "ご報告ありがとうございます。"
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :customer_id, :post_id, :img_big, :author, :publisher, :item_caption)
  end
end

