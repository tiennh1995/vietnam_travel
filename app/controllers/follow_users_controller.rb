class FollowUsersController < ApplicationController
  before_action :load_data_static

  def index
    @type = params[:type] || "following"
    @users = current_user.send(@type).order id: :desc
    unless @users.empty?
      follow_users_offset = params[:follow_users_offset] || @users.first.id
      @users = @users.where("users.id <= ?", follow_users_offset)
        .limit Settings.length_more_user
      @last = (@users.size < Settings.length_more_user) ? true : false
    end
  end
end
