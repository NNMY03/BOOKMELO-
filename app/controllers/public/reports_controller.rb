class Public::ReportsController < ApplicationController
  
  def new
   @report = Report.new
   @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.find(params[:post_id])
    @report = Report.new(report_params)
    if @report.save
      redirect_to post_path(@post), notice: "ご報告ありがとうございます。"
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end
end

