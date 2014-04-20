class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships, source: :user
  has_many :comments
  has_many :events

  validate :name, presence: true

  def add_user(user)
    begin
      users << user
    rescue ActiveRecord::RecordNotUnique
      false
    end
  end

  def admin(user)
    membership = memberships.find_by user: user
    membership.admin= true
    membership.save
  end
end
