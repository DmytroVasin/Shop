module Order::OrderValidations
  def self.included(base)
    base.class_eval do
      validates :phone, phony_plausible: true

      validates :phone, numericality: true
      validates :terms_of_service, acceptance: true
      validates :region, inclusion: Order::REGIONS
      validates :status, inclusion: Order::STATUSES
      validates :email, :name, :surname, :phone, :region, :city, :payment_method, presence: true
      validates :name, :surname, length: { minimum: 2, maximum: 254 }
      validates :email, length: { minimum: 7, maximum: 254 },
                        format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                                  message: "must be a valid email address" }

    end
  end
end
