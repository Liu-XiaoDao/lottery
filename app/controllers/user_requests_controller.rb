class UserRequestsController < ApplicationController
  layout 'template'

  def index
    @user_requests = UserRequest.all
  end
end
