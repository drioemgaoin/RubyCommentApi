  class CommentChannel < ApplicationCable::Channel
    def subscribed
      logger.info 'Subscribe to Comment Channel'
      stream_from "comment_channel"
    end

    def unubscribed
    end
  end
