class User < ActiveResource::Base
  has_many :comments

  self.site = ENV['AUTHENTICATION_API']
  self.element_name = "user"
  self.format = ::JsonFormatter.new(:users)

  def self.collection_name
    element_name
  end

  def comments
    Comment.where(user_id: self.id)
  end
end
