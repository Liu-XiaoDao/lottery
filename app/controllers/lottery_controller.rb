class LotteryController < ApplicationController
  layout 'home'
  def index
  end

  def index_test
  end

  def index_old
  end

  def lottery_batch_new
    render layout: false
  end

  def lottery_batch
    render layout: false
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
    ActionCable.server.broadcast 'signin', message: {user_info: User.last, signin_count: User.signin_count}
    render plain: "wewewewe"
  end
end
