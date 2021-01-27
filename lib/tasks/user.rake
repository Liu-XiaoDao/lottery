namespace :user do
  desc "从用户列表创建抽奖列表"
  task create_user: :environment do
    UserList.all.each do |ul|
      User.create(name: ul.name)
    end
  end

end
