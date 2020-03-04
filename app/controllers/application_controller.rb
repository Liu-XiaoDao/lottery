class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  http_basic_authenticate_with name: "yk_labour_union", password: "YKgonghui!123?"
  before_action :load_config

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
end
