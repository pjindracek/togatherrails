class EventsController < ApplicationController
  before_action :authenticate_user!, :load_group
  before_action :add_event, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    adjust_group
    if @event.save
      redirect_to group_path(id: @group), notice: 'Event was successfully created.'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to group_path(id: @group), notice: 'Event was updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to group_path(params[:group_id]), notice: 'Event was deleted.'
  end

  private

  def load_group
    @group = Group.find(params[:group_id])
  end

  def add_event
    @event = Event.find(params[:id])
  end

  def adjust_group
    @event.group = current_user.administrated_groups.find(params[:group_id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :beginning, :end)
  end

end
