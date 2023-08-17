class Admin::ReportsController < ApplicationController
  def index
    @reports = Report.all
  end
  
  def show
    @report = Report.find(params[:id])
  end
  
  private

  def report_params
    params.require(:report).permit(:status)
  end
  
end