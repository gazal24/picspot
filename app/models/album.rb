class Album < ActiveRecord::Base
  validates_length_of :name, :within => 3..40
  belongs_to :user
  has_many :pictures
end

