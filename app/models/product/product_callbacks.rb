module Product::ProductCallbacks
  def self.included(base)
    base.class_eval do
      before_destroy :not_referenced_by_any_line_items
    end
  end

  private

  def not_referenced_by_any_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base, 'cant destroy - line_items is present')
      return false
    end
  end
end
