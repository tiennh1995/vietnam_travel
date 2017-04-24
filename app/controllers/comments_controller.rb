class CommentsController < ApplicationController
  before_action :load_image, only: :index

  def index
    comment_offset = params[:comment_offset] || 0
    @comments = @image.main_comments.where("id > ?", comment_offset)
      .limit Settings.load_more_comment_size
    @last = (@comments.size < Settings.load_more_comment_size) ? true : false
  end

  private
  def load_image
    @image = Image.find_by id: params[:image_id]
    unless @image
      flash[:danger] = "写真は存在じゃない。"
      redirect_to root_path
    end
  end
end
