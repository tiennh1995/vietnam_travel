class LikesController < ApplicationController
	 before_action :load_image

  def create
    @like = @image.feed_backs.new
    @like.user = current_user
    @like.feed_back_type = "like"
    @like.save
    redirect_to root_path
  end

  private
  def load_image
    @image = Image.find_by id: params[:image_id]
    unless @image
      flash[:danger] = "写真は存在じゃない。"
      redirect_to root_path
    end
  end

  def new
  end

end
