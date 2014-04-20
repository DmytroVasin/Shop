module Product::ProductValidations
  def self.included(base)
    base.class_eval do
      validates :title, :price, presence: true
      validates :price, numericality: { greater_than_or_equal_to: 0.01 }
      validates :old_price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
      validates :rank, numericality: { only_integer: true }
      validates :brand, :categories, presence: true
      validates :title, uniqueness: { case_sensitive: false }
      validate  :price_must_be_gr_than_old_price
    end
  end

  private

  def price_must_be_gr_than_old_price
    if self.old_price
      errors.add(:price, "must be greater then old price") if self.old_price.to_f <= self.price.to_f
    end
  end
end
