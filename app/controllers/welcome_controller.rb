class WelcomeController < ApplicationController
  layout 'template'
  def index
    if params[:_id] && User.find(params[:_id])
      @user = User.find(params[:_id])
    end
    @count = User.count
    @count_active = User.where(is_active: true).count
  end

  def scan_code
    render layout: false
  end
end
