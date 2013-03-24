class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type, :phone

  validates :terms_of_service, acceptance: true

  PAYMENT_TYPES = ["New poshta", "Ukr poshta"]
end
