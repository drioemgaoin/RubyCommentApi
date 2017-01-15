  class CommentChannel < ApplicationCable::Channel
    def subscribed
      stream_from "comment"
    end

    def unubscribed
      stop_all_streams
    end
  end
