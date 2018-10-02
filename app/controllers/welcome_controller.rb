class WelcomeController < ApplicationController
  layout 'template'
  def index
    if params[:id] && User.find(params[:id])
      @user = User.find(params[:id])
    end
    @count = User.count
    @count_active = User.where(is_active: true).count
  end
end
