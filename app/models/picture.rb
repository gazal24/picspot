class Picture < ActiveRecord::Base
  belongs_to :directory
  belongs_to :user
  has_many :comments
end
