require 'paperclip'
class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments

  has_attached_file :photo,
  :styles => {
    :thumb => "75x75>",
    :small => "150x150>",
    :large => "500x500>"    
  }
  
end
