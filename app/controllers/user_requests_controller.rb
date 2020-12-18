class UserRequestsController < ApplicationController
  layout 'template'
  http_basic_authenticate_with name: "yk_labour_union", password: "YKgonghui!123?"

  def index
    @user_requests = UserRequest.all.paginate page: params[:page], per_page: 18
  end
end
