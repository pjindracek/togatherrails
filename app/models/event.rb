class Event < ActiveRecord::Base
  belongs_to :group
  has_and_belongs_to_many :users

  validates :title, :description, :beginning, :end, presence: true

  def is_user_attending? user
    users.where("users.id = ?", user).present?
  end
end
