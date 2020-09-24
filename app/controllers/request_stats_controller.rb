class RequestStatsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "Abcam123$"
  layout 'template'

  def index
    @request_stats = RequestStat.all.paginate page: params[:page], per_page: 18
  end
end
