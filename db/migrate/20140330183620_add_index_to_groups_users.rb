class AddIndexToGroupsUsers < ActiveRecord::Migration
  def change
    add_index :groups_users, [ :group_id, :user_id ], :unique => true, :name => 'by_group_id_user_id'
  end
end
