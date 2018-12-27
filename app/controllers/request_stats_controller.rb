class RequestStatsController < ApplicationController
  layout 'template'

  def index
    @request_stats = RequestStat.all
  end
end
