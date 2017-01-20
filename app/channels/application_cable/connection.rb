module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      logger.info 'Connection to Action cable'
    end
  end
end
