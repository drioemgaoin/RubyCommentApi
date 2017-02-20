class CommentService
  def get_all
    comments = Comment.all
    users = User.all

    comments.each do |comment|
      user = users.detect { |user| user.email == comment.email }
      if user
        comment.username = "#{user.first_name} #{user.last_name}"
      end
    end

    comments
  end
end
