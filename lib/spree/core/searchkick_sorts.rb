module Spree
  module Core
    module SearchkickSorts
      def self.applicable_sorts
        {
          'relevance' => { sort: { _score: :desc }, label: "Relevance" },
          'price_asc' => { sort: { price: :asc }, label: "Price Low to High" },
          'price_desc' => { sort: { price: :desc }, label: "Price High to Low" },
          'popularity' => { sort: { conversions: :desc }, label: 'Popularity' }
        }
      end
      def self.current_sort(params)
        if params[:sort]
          found_sort = applicable_sorts[params[:sort]]
          if found_sort
            return found_sort[:label]
          end
        end
        'Relevance'
      end

      def self.process_sorts(params)
        if params[:sort]
          valid_sorts = applicable_sorts
          found_sort = valid_sorts[params[:sort]]
          return found_sort[:sort] if found_sort
        end
        {}
      end
    end
  end
end
