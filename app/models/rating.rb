class Rating < ActiveRecord::Base
  attr_accessible :ip, :point

  validates :ip, uniqueness: true
end
