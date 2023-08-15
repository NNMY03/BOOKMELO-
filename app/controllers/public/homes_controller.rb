class Public::HomesController < ApplicationController
  def top
  end

  def attention
    @home = Home.new
    
  end
end

def home_params
  params.require(:home).permit(:attention)
end