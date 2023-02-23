class NotificationMailer < ApplicationMailer
  def register_msg(obj)
    @obj = obj
    mail(to: 'chunliang.liu@foxmail.com', subject: '宜康电脑摇号报名通知')
  end
end
