class User < ActiveRecord::Base
  has_many :directories
end
