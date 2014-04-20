module Product::ProductScopes
  def self.included(base)
    base.class_eval do
      scope :newest, -> { order('updated_at DESC') }
      scope :high, -> { order('price DESC') }
      scope :low, -> { order('price ASC') }
      scope :best, -> { order('rank DESC') }
      scope :by_gender, ->(g) { joins(:genders).where('genders.gender = ?', g ) }
      scope :count_of_best_sellers, -> { where(bestseller: true) }

      def self.search(search)
        if search
          where('title like ?', "%#{search}%")
        else
          scoped
        end
      end

      def self.selecting_by(params_arr, type, ing = '', name = 'name')
        if params_arr
          where_query = "#{type}#{ing}.#{name} = ?"
          (params_arr.count - 1).times do
            where_query << " OR #{type}#{ing}.#{name} = ?"
          end

          query_full = []
          query_full = query_full.push(where_query)

          params_arr.each { |x| query_full.push(x) }

          joins(:"#{type}").where(query_full).uniq(&:id)
        else
          scoped
        end
      end

      def self.price_between(params_arr)
        if params_arr
          price_arr = params_arr.split(',')
          where("price between ? AND ?", price_arr[0], price_arr[1])
        else
          scoped
        end
      end

      def self.sort_direction(direction, hash_of_sort)
        if hash_of_sort.values.include? direction
          self.send(direction.to_sym)
        else
          scoped
        end
      end

      def self.selecting_by_keys(keys, column_name)
        if keys
          where("#{column_name} ?| ARRAY[:keys]", keys: keys)
        else
          scoped
        end
      end

    end
  end
end
