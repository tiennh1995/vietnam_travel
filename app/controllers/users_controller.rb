class UsersController < ApplicationController
  before_action :load_user

  def show
    @images = @user.images.order id: :desc
    unless @images.empty?
      image_offset = params[:image_offset] || (@images.first.id + 1)
      @images = @images.where("id < ?", image_offset)
        .limit Settings.load_more_image_size
      @last = (@images.size < Settings.load_more_image_size) ? true : false
    end
  end

  def update
    errors = @user.update_profile user_params: user_params,
      profile_params: profile_params
    if errors.nil?
      flash[:success] = "アップデイト成功した"
      redirect_to user_path(@user)
    else
      respond_to do |format|
        format.html do
          @images = @user.images.order(id: :desc).limit 5
          flash[:danger] = "アップデイト成功さなかった"
          render :show
        end
        format.js
      end
    end
  end

  private
  def user_params
    params.require(:user).permit :full_name, :sex, :avatar, :cover
  end

  def profile_params
    params.require(:profile).permit(:phone_number, :birthday,
      :place_birth) if params[:profile]
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "ユーザーは存在じゃない"
      redirect_to root_path
    end
  end
end
