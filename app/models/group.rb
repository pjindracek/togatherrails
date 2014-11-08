class Group < ActiveRecord::Base
  has_many :memberships, dependent: :delete_all
  has_many :users, through: :memberships, source: :user
  has_many :comments, dependent: :delete_all
  has_many :events, dependent: :delete_all

  validates :name, presence: true
  validates :motto, presence: true

  enum category: [:culture, :business, :sport, :social, :family, :religion, :food, :technology, :hobbies, :pets]

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

  def past_events
    events.where("events.end < ?", Time.now)
  end

  def self.search(query)
    if query
      query= "%#{query}%"
      Group.where('groups.name LIKE ? OR groups.motto LIKE ?', query, query)
    else
      nil
    end
  end

  def members_count
    self.memberships.count
  end
end
