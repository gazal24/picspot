require 'paperclip'
class Picture < ActiveRecord::Base
  has_attached_file :photo,
  :styles => {
    :thumb => "75x75>",
    :small => "150x150>"
  }
  
end
