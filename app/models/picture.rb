require 'paperclip'
class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments

  has_attached_file :photo
  validates_presence_of :photo
end
