class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :load_config
  before_action :check_ip

  def process_action *args
    time = Time.now
    rslt = super
    filtered_params = request.params.reject{|k, v| k.match('photo') || k.match('file') || v.empty?}
    ur=UserRequest.create(
      :url => request.url,
      :time => (Time.now-time),
      :path => request.path.gsub(/\d+/, ':id'),
      :params => JSON[filtered_params.merge(method: request.method)],
      :remote_ip => request.remote_ip
    )
    rslt
  end

  private
    #加載配置文件
    def load_config
      @web_config = Rails.application.config_for(:web_config)
    end

    def check_ip
      render plain: "请求太频繁了!!!" if UserRequest.where(remote_ip: request.remote_ip, created_at: (Time.now - 1.minutes)..Time.now).count > 20
    end
end
