module ApplicationHelper
  #当前所在类别激活
  def check_if_active(text,path)
    text == path ? "uk-active" : ""
  end
end
