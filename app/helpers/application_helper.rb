module ApplicationHelper
  def avatar_profile user
    if user && user.avatar
      user.avatar.url
    else
      "#{user.sex}.png"
    end
  end

  def user_reply_comment comment
    if comment
      comment_reply = comment.reply_comment
      if comment_reply && comment_reply.user != comment.user
        link_to comment_reply.user.full_name, "#"
      end
    end
  end
end
