class LotteryController < ApplicationController
  layout 'home'
  def index
  end

  def index_old
  end

  def universe
    render layout: false
  end

  def milky_way
    render layout: false
  end

  def signin
    render layout: false
  end

  def signin_test
    render layout: false
  end
end
