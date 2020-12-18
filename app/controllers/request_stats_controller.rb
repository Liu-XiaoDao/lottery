class RequestStatsController < ApplicationController
  layout 'template'
  http_basic_authenticate_with name: "yk_labour_union", password: "YKgonghui!123?"

  def index
    @request_stats = RequestStat.all.paginate page: params[:page], per_page: 18
  end
end
