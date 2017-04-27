module ApplicationHelper
  def avatar_profile user
    if user && user.avatar_url
      user.avatar_url
    else
      "#{user.sex}.png"
    end
  end

  def user_reply_comment comment
    if comment
      comment_reply = comment.reply
      if comment_reply && comment_reply.user != comment.user
        link_to comment_reply.user.full_name, comment_reply.user
      end
    end
  end
end
