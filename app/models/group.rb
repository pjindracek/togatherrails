class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships, source: :user
  has_many :comments
  has_many :events

  validate :name, presence: true

  def add_user(user)
      users << user
  end

  def remove_user(user)
    users.delete(user)
  end

  def admin=(user)
    add_user user
    membership = memberships.find_by user: user
    membership.admin= true
    membership.save
  end

  def admin
    membership = memberships.where("admin = ?", true).first
    membership.user if membership.present?
  end

  def is_admin?(user)
    return false if user.blank?
    user == admin
  end

  def is_member?(user)
    return false if user.blank?
    memberships.find_by(user: user).present?
  end

  def current_events
    events.where("events.end > ?", Time.now)
  end
end
