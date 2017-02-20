class Comment < ApplicationRecord
  belongs_to :user, polymorphic: true

  def all
    self.all.map { |comment|  }
  end

  def user
    User.find(self.user_id)
  end
end
