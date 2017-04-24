class ImagesController < ApplicationController
  def index
    @images = current_user.images_news_feed
    unless @images.empty?
      image_offset = params[:image_offset] || @images.first.id
      @images = @images.where("id < ?", image_offset)
        .limit Settings.load_more_image_size
      @last = (@images.size < Settings.load_more_image_size) ? true : false
    end
  end
end
