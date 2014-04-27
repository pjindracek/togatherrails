class UsersController < ApplicationController
  before_action :authenticate_user!, only: :profile

  def profile
    if params[:id].present?
      @user = User.find(params[:id])
      @public_user = true
    else
      @user = current_user
      @public_user = false
      @groups_admin = current_user.administrated_groups
    end
  end

end
