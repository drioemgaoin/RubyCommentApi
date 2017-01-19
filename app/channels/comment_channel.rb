  class CommentChannel < ApplicationCable::Channel
    def subscribed
      stream_from "comment_channel"
    end

    def unubscribed
    end
  end
