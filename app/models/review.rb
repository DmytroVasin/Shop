class Review < ActiveRecord::Base
  attr_accessible :ip, :point
	#TODO: ADD VALIDATION
  validates :ip, uniqueness: true
end
