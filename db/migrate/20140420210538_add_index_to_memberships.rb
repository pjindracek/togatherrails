class AddIndexToMemberships < ActiveRecord::Migration
  def change
    add_index :memberships, [ :group_id, :user_id ], :unique => true, :name => 'by_group_id_user_id'
  end
end
