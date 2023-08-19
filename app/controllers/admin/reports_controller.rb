class Admin::ReportsController < ApplicationController
    before_action :set_report_status, only: [:update]

  def index
    @reports = Report.all.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def update
    @reports = Report.find(params[:id])
    if @reports.update(report_params)
      flash[:notice] = "対応ステータスを更新しました"
      redirect_to admin_reports_path
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