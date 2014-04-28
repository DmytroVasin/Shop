module Category::CategoryScopes
  def self.included(base)
    base.class_eval do
      def get_three_also_viewed_products
        products.sample(3)
      end

      def self.get_three_also_viewed_products_with category
        find(category).get_three_also_viewed_products
      end
    end
  end
end
