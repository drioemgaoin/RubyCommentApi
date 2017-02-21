class Comment < ApplicationRecord
  belongs_to :user, polymorphic: true

  attr_accessor :username, :avatar

  def self.aggregate
    comments = Comment.all
    users = User.all

    comments.each do |comment|
      user = users.detect { |user| user.id == comment.user_id }
      if user
        comment.avatar = user.avatar
        comment.username = "#{user.first_name} #{user.last_name}"
      end
    end

    comments
  end

  def as_json(options={})
    options ||= {}
    options[:methods] = ((options[:methods] || []) + [:username, :avatar])
    options[:except] = [:user_id]
    super options
  end
end
