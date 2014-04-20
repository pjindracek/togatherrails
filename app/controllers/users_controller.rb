class UsersController < ApplicationController
  before_action :set_current_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def profile
    if @current_user.nil?
      render 'welcome/index'
    end
  end

  private

    def set_current_user
      @user = @current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password_raw, :password_raw_confirmation, :bio)
    end
end
