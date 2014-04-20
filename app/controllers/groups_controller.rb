class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :register]
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.administrator= current_user

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
      format.html { redirect_to groups_url }
    end
  end

  def register
    if @group.add_user current_user
      redirect_to profile_path, notice: "Yay! You are member of #{@group.name} now."
    else
      redirect_to group_path, alert: 'Error occurs. You are already a member!'
    end
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :motto)
    end
end
