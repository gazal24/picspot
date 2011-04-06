class Friend < ActiveRecord::Base
  has_many :users
  validates_presence_of :user1
  validates_presence_of :user2  
  validates_presence_of :accepted
end
