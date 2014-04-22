class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :title, :message, presence: true

end
