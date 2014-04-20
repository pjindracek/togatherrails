class UsersController < ApplicationController
  before_action :authenticate_user!, only: :profile

  def profile
    @groups_all = current_user.groups
    @groups_admin = current_user.administrated_groups
  end

end
