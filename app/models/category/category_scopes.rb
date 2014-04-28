module Category::CategoryScopes
  def self.included(base)
    base.class_eval do
      def get_three_also_viewed_products_without_current product
        products.except_product(product).sample(3)
      end

      def self.get_three_also_viewed_products_with category, product
        find(category).get_three_also_viewed_products_without_current(product)
      end
    end
  end
end
