class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :group
      t.references :user
      t.boolean :admin

      t.timestamps
    end
  end
end
