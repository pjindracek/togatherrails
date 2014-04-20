require 'digest/sha1'

class User < ActiveRecord::Base

  attr_accessor :password_raw

  has_many :groups
  has_and_belongs_to_many :groups, -> { uniq }
  has_many :comments
  has_and_belongs_to_many :events

  validates :name, :email, presence: true
  validates_uniqueness_of :email
  validates_length_of :email, :within => 5..100
  validates_format_of :email, with: /[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}/i
  validates :password_raw, confirmation: true
  validates_presence_of :password_raw_confirmation, if: :creating_new_password?

  before_save :encrypt_new_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.password == encrypt(password)
  end

  protected

  def encrypt_new_password
    return if password_raw.blank?
    self.password= encrypt password_raw
  end

  def encrypt(password)
    Digest::SHA1.hexdigest password
  end

  def creating_new_password?
    password.blank? || password_raw.present?
  end

end
