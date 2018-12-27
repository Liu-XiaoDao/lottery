class RequestStatsController < ApplicationController
  layout 'template'

  def index
    @request_stats = RequestStat.all.paginate page: params[:page], per_page: 18
  end
end
