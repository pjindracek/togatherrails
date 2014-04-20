class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.datetime :date
      t.text :message
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
