class RemoveAdministratorIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :administrator_id, :integer
  end
end
