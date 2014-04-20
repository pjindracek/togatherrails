class Group < ActiveRecord::Base
  belongs_to :administrator, :foreign_key => 'administrator_id', :class_name => 'User'
  has_and_belongs_to_many :users, -> { uniq }
  has_many :comments
  has_many :events


end
