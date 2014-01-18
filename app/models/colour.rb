class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus

  has_many :colors
  has_many :products, through: :colors

  def r_name
  	if self.name_rus
  		self.name_rus
  	else
  		'----'
  	end
  end
end
