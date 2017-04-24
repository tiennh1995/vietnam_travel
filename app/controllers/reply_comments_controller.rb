class ReplyCommentsController < ApplicationController
  before_action :load_comment, only: :index

  def index
    reply_comment_offset = params[:reply_comment_offset] || 0
    @reply_comments = @comment.reply_comments.where("id > ?",
      reply_comment_offset).limit Settings.load_more_reply_comment_size
    @last = (@reply_comments.size < Settings
      .load_more_reply_comment_size) ? true : false
  end

  private
  def load_comment
    @comment = Comment.find_by id: params[:comment_id]
    unless @comment
      flash[:danger] = "コメントは存在じゃない。"
      redirect_to root_path
    end
  end
end
