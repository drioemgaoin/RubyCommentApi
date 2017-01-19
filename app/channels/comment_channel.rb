  class CommentChannel < ApplicationCable::Channel
    def subscribed
      puts "Subscribe to Comment Channel"
      stream_from "comment_channel"
    end

    def unubscribed
      puts "Unsubscribe to Comment Channel"
      stop_all_streams
    end
  end
