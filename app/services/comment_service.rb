class CommentService
  def get_all
    comments = Comment.all.to_a
    users = User.all.to_a
    puts comments
    puts users
    comments.each do |comment|
      user = users.detect { |user| user.email == comment.email }
      if user
        comment.send("avatar=", "pouet")
        # comment.avatar = "pouet"
        puts comment.avatar
        comment.username = "#{user.first_name} #{user.last_name}"
      end
    end

    comments[0].avatar = "pouet"
    puts comments[0].avatar
    puts comments[0].inspect

    comments
  end
end
