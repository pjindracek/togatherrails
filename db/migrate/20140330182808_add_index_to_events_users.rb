class AddIndexToEventsUsers < ActiveRecord::Migration
  def change
    add_index :events_users, [ :event_id, :user_id ], :unique => true, :name => 'by_event_id_user_id'
  end
end
