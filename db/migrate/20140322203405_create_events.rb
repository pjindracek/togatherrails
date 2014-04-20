class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :beginning
      t.datetime :end
      t.integer :group_id

      t.timestamps
    end
  end
end
