class NotificationMailer < ApplicationMailer
  def register_msg(obj)
    @obj = obj
    mail(to: '957419420@qq.com', subject: '报名通知')
  end
end
