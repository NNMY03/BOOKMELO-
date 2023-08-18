class Admin::ReportsController < ApplicationController
    before_action :set_report_status, only: [:update]
  
  def index
    @reports = Report.all.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def update
    if @reports.update(report_params)
      redirect_to admin_reports, notice: "対応ステータスを更新しました"
    else
      render :index, alert: "対応ステータスを更新できませんでした"
    end
    
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end
  
  def set_report_status
    @report = Report.find(params[:id])
  end


end