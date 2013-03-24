class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :surname, :pay_type, :phone, :additional_phone, :region, :city, :info

  PAYMENT_TYPES = ["New poshta", "Ukr poshta"]

  has_many :line_items, dependent: :destroy

  validates :terms_of_service, acceptance: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :address, :email, :name, :surname, :phone, :region, :city, presence: true

end
