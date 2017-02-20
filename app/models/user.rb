class User < ActiveResource::Base
  self.site = ENV['AUTHENTICATION_API']
  self.format = ::JsonFormatter.new(:users)
end
