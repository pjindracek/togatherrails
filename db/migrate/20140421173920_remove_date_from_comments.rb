class RemoveDateFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :date, :datetime
  end
end
