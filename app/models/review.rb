class Review < ActiveRecord::Base
  attr_accessible :full_name, :address, :url_id, :delivery_time, :quality, :suggestions

  before_validation :url_id_is_exist
  
  def url_id_is_exist
  	self.url_id = self.url_id.split('/')[-1].gsub(/\D/, '').to_i

  	unless Product.pluck(:id).include?( self.url_id )
  		errors.add(:url_id,'mistake')
  	end
  end
end
