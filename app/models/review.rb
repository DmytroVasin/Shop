class Review < ActiveRecord::Base
  attr_accessible :full_name, :address, :url_id, :delivery_time, :quality, :suggestions

  validates :full_name, presence: true
  validates :address, presence: true
end
