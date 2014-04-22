class EventsController < ApplicationController
  before_action :authenticate_user!, :load_group
  before_action :add_event, except: [:new, :create]

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

  def register
    if @event.users << current_user
      redirect_to group_event_path(group_id: @group, id: @event),
                  notice: "Yay! You were added to the event #{@event.title}."
    else
      redirect_to group_event_path(group_id: @group, id: @event),
                  alert: "Error occurred. You are already registered for event #{@event.title}!"
    end
  end

  def unregister
    @event.users.delete current_user
    redirect_to group_event_path(group_id: @group, id: @event),
                notice: "You've left event #{@event.title}"
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
