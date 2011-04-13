require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :albums
  
  validates_length_of :name, :within => 3..40
  validates_length_of :email, :within => 3..40  
  validates_length_of :password, :within => 5..40
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  validates_confirmation_of :password
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid Email"
  
  def self.authenticate(email, password)
    u = User.all(:first, :conditions => {:email, email, :password, password})
    if u.blank?
      return nil
    else
      u = User.find(u.to_param.to_i)
      return u
    end
  end

end

