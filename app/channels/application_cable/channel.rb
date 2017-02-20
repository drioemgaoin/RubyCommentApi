module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      logger.info 'Subscribe to Channel'
    end
  end
end
