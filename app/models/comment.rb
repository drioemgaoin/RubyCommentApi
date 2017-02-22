class Comment < ApplicationRecord
  after_commit :set_user_infos, on: [:create, :update]
  after_find :set_user_infos, on: [:all, :find]

  attr_accessor :username, :avatar

  def set_user_infos
    user = User.all.detect { |user| user.id == self.user_id }
    if user
      self.avatar = user.avatar
      self.username = "#{user.first_name} #{user.last_name}"
    end
  end

  def as_json(options={})
    options ||= {}
    options[:methods] = ((options[:methods] || []) + [:username, :avatar])
    options[:except] = [:user_id]
    super options
  end
end
