class Public::ReportsController < ApplicationController
  
  def new
   @report = Report.new
   @book = Book.find(params[:book_id])
  end
  
  def create
    @book = Book.find(params[:book_id])
    @report = Report.new(report_params)
    if @report.save
      redirect_to book_path(@book), notice: "ご報告ありがとうございます。"
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :book_id, :img_big, :author, :publisher, :item_caption)
  end
end

