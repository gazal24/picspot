class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments
end
