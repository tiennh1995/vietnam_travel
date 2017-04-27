class ImagesController < ApplicationController
  def index
    @images = current_user.images_news_feed
    unless @images.empty?
      image_offset = params[:image_offset] || (@images.first.id + 1)
      @images = @images.where("id < ?", image_offset)
        .limit Settings.load_more_image_size
      @last = (@images.size < Settings.load_more_image_size) ? true : false
    end
  end

  def new
    @image = Image.new
    @categories = Category.all
  end

  def create
    @image = Image.new image_params
    @image.user_id = current_user.id

    if @image.save
      flash[:success] = "アップロードに成功しました"
      redirect_to root_path
    else
      respond_to do |format|
        format.html do
          flash[:danger] = "アップロードに失敗しました"
          redirect_to root_path
        end
        format.js
      end
    end
  end

  private
  def image_params
    params.require(:image).permit :description, :image, :address, :category_id
  end
end
