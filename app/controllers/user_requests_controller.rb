class UserRequestsController < ApplicationController
  layout 'template'

  def index
    @user_requests = UserRequest.all.paginate page: params[:page], per_page: 18
  end
end
