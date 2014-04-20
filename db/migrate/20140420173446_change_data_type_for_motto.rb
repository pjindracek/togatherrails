class ChangeDataTypeForMotto < ActiveRecord::Migration
  change_table :groups do |t|
    t.change :motto, :text
  end
end
