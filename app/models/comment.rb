class Comment < ApplicationRecord
  belongs_to :user, polymorphic: true

  def user
    User.find(self.user_id)
  end

  def as_json(options={})
    user_infos = user
    h = super(:only => [:content, :created_at])
    h[:username] = "#{user_infos.first_name} #{user_infos.last_name}"
    h[:avatar] = user_infos.avatar
    h
  end
end
