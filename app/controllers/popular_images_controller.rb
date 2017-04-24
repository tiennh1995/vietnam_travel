class PopularImagesController < ApplicationController
  before_action :load_data_static

  def index
    image_offset = params[:image_offset] || 0
    @images = Image.popular_images.where("id > ?", image_offset)
      .limit Settings.load_more_image_size
    @last = (@images.size < Settings.load_more_image_size) ? true : false
  end
end
