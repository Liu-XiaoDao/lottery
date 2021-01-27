class LotteryController < ApplicationController
  layout 'home'
  def index
  end

  def index_test
  end

  def index_old
  end

  def lottery_batch_new
    @users = User.first(190)
    @users_json = @users.map{|u| {name: u.name, jobNo: "00#{u.id}", lucky: '', deptName: 'xxx', dept4Name: 'xxxx'}}.to_json
    render layout: false
  end

  def lottery_batch
    @users = User.first(190)
    @users_json = @users.map{|u| {name: u.name, jobNo: "00#{u.id}", lucky: '', deptName: 'xxx', dept4Name: 'xxxx'}}.to_json
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


  # 慈善抽奖
  def charity
    render layout: false
  end

  # 慈善抽奖结果
  def charity_result
    render layout: false
  end
end
