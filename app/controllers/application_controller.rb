class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :load_config

  private
    #加載配置文件
    def load_config
      @web_config = Rails.application.config_for(:web_config)
    end
end
