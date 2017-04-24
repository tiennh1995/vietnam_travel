class ImagesController < ApplicationController
  def index
  	@image = Image.new
    @images = current_user.images_news_feed
    unless @images.empty?
      image_offset = params[:image_offset] || @images.first.id
      @images = @images.where("id < ?", image_offset)
        .limit Settings.load_more_image_size
      @last = (@images.size < Settings.load_more_image_size) ? true : false
    end
  end

  def create
    @image = Image.new image_params
    @image.user_id = current_user.id
    
    if @image.save
      flash[:success] = "アップロードに成功しました"
    else
      flash[:danger] = "アップロードに失敗しました"
    end
    redirect_to root_path
  end

  private
  def image_params
    params.require(:image).permit :description, :image, :address, :category_id
  end
end
