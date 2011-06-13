require 'paperclip'

class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments
  has_attached_file :photo,
  :path => ':rails_root/public/system/:id.:extension',
  :styles => {
    :thumb=> "100x100#",
    :small  => "150x150>" }
end
