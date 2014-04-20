class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable

  has_many :administrated_groups, :foreign_key => 'administrator_id', :class_name => 'Group'
  has_and_belongs_to_many :groups, -> { uniq }
  has_many :comments
  has_and_belongs_to_many :events

  validates :name, :email, presence: true
  validates_uniqueness_of :email
  validates_length_of :email, :within => 5..100
  validates_format_of :email, with: /[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}/i
  validates :password, confirmation: true
  validates_presence_of :password_confirmation, if: :creating_new_password?

  def creating_new_password?
    encrypted_password.blank? || password.present?
  end

  def all_user_groups
    groups + administrated_groups
  end

  def add_group(group)
    groups << group
  end
end
