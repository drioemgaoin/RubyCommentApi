class Comment < ApplicationRecord
  after_commit :set_user_infos, on: [:create, :update]
  after_find :set_user_infos, on: [:all, :find]

  attr_accessor :avatar

  def set_user_infos
    if self.user_id
      user = User.find self.user_id
      if user
        self.avatar = user.avatar
        self.username = "#{user.first_name} #{user.last_name}"
      end
    end
  end

  def as_json(options={})
    options ||= {}
    options[:methods] = ((options[:methods] || []) + [:username, :avatar])
    options[:except] = [:user_id]
    super options
  end
end
