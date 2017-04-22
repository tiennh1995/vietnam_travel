class PagesController < ApplicationController
  before_action :load_data

  def show
  end

  private
  def load_data
    if user_signed_in?
      #@followings = current_user.just_followed
      @followings = User.all
      @know_users = User.all
      @popular_images = Image.popular_images
      @images = current_user.images_news_feed
    else
    end
  end
end
