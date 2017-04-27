class ReplyCommentsController < ApplicationController
  before_action :load_comment, :load_parent_comment
  before_action :load_reply_comment, except: [:index, :new, :create]

  def index
    @reply_comments = @comment.reply_comments
    reply_comment_offset = params[:reply_comment_offset] || (@reply_comments
      .first.id + 1)
    @reply_comments = @reply_comments.where("id < ?", reply_comment_offset)
      .limit Settings.load_more_reply_comment_size
    @last = (@reply_comments.size < Settings
      .load_more_reply_comment_size) ? true : false
  end

  def new
  end

  def create
    @reply_comment = Comment.new comment_params
    @reply_comment.image = @comment.image
    @reply_comment.user = current_user
    @success = @reply_comment.save
  end

  def edit
  end

  def update
    @reply_comment.update_attributes comment_params
  end

  def destroy
    @reply_comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit :reply_id, :content, :parent_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:comment_id]
    unless @comment
      flash[:danger] = "コメントは存在じゃない。"
      redirect_to root_path
    end
  end

  def load_parent_comment
    @parent_comment = @comment.parent
    @parent_comment ||= @comment
  end

  def load_reply_comment
    @reply_comment = Comment.find_by id: params[:id]
    unless @reply_comment
      flash[:danger] = "コメントは存在じゃない。"
      redirect_to root_path
    end
  end
end
