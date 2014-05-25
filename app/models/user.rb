class User < ActiveRecord::Base
  acts_as_authentic do |a|
    a.validate_login_field = true
    a.validate_password_field = true
    a.require_password_confirmation = true
    a.logged_in_timeout = 10.minutes # default is 10.minutes
  end
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  attr_accessible :name, :login, :email, :password, :password_confirmation
  validates_presence_of :name, :login, :email, :password, :password_confirmation
  validates_length_of :name, :in => 3..225
  validates_uniqueness_of :name, :login, :email

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end
end
