class ImagesController < ApplicationController
  before_action :load_data_static, only: :show
  before_action :load_image, except: [:index, :new, :create]

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

  def show
  end

  def edit
    @categories = Category.all
  end

  def update
    if @image.update_attributes image_params
      flash[:success] = "アップデイト成功した"
      redirect_to @image
    end
  end

  def destroy
    if current_user == @image.user && @image.destroy_images
      flash[:success] = "削除成功した。"
    else
      flash[:danger] = "削除失敗した。"
    end
    redirect_to root_path
  end

  private
  def image_params
    params.require(:image).permit :description, :image, :address, :category_id
  end

  def load_image
    @image = Image.find_by id: params[:id]
    unless @image
      flash[:danger] = "写真は存在じゃない。"
      redirect_to root_path
    end
  end
end
