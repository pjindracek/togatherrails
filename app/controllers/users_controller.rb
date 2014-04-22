class UsersController < ApplicationController
  before_action :authenticate_user!, only: :profile

  def profile
    if params[:id].present?
      @public_user = User.find(params[:id])
    else
      @groups_all = current_user.groups
      @groups_admin = current_user.administrated_groups
    end
  end

end
