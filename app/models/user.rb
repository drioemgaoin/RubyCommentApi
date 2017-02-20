class User < ActiveResource::Base
  self.site = "http://localhost:4000/"
  self.format = ::JsonFormatter.new(:users)
end
