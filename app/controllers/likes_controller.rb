class LikesController < ApplicationController
  before_action :load_image
  before_action :load_like, only: :destroy

  def create
    @like = @image.feed_backs.new
    @like.user = current_user
    @like.feed_back_type = "like"
    @like.save
  end

  def destroy
    @like.destroy
  end

  private
  def load_image
    @image = Image.find_by id: params[:image_id]
    unless @image
      flash[:danger] = "写真は存在じゃない。"
      redirect_to root_path
    end
  end

  def load_like
    @like = current_user.likes.find_by id: params[:id]
    unless @like
      flash[:danger] = "存在じゃない。"
      redirect_to root_path
    end
  end
end
