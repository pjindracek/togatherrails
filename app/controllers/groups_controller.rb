class GroupsController < ApplicationController
  before_action :set_group_for_user, only: [:show, :register, :unregister]
  before_action :set_group_for_admin, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @group.admin= current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to profile_url, notice: "You have deleted the group #{@group.name}." }
    end
  end

  def register
    if @group.add_user current_user
      redirect_to profile_path, notice: "Yay! You are a member of #{@group.name} now."
    else
      redirect_to group_path, alert: "Error occurred. You are already a member of #{@group.name}!"
    end
  end

  def unregister
    @group.remove_user current_user
    redirect_to profile_path, notice: "You've just left #{@group.name}"
  end

  private

  def set_group_for_user
    @group = find_group_by_id
  end

  def set_group_for_admin
    set_group_for_user if find_group_by_id.is_admin? current_user
  end

  def group_params
    params.require(:group).permit(:name, :motto)
  end

  def find_group_by_id
    Group.find(params[:id])
  end
end
