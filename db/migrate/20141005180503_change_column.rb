class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :groups, :category, :integer, default: 0
  end

  def down
    change_column :groups, :category, :integer, default: nil
  end
end
