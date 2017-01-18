module Spree
  module Core
    module SearchkickSorts
      def self.applicable_sorts
        {
          'featured' => { sort: { list_position: :asc }, label: "Featured" },
          'relevance' => { sort: { _score: :desc }, label: "Relevance" },
          'popularity' => { sort: { conversions: :desc }, label: 'Popularity' },
          'price_asc' => { sort: { price: :asc }, label: "Price Low to High" },
          'price_desc' => { sort: { price: :desc }, label: "Price High to Low" }
        }
      end

      def self.current_sort(params)
        sort = active_sort(params)
        sort[:label]
      end

      def self.process_sorts(params)
        sort = active_sort(params)
        sort[:sort]
      end

      def self.active_sort(params)
        found_sort = applicable_sorts[params[:sort]] if params[:sort]
        found_sort ||= applicable_sorts[default_sort_key(params)]
      end

      def self.default_sort_key(params)
        if params[:keywords].blank?
          'featured'
        else
          'relevance'
        end
      end
    end
  end
end
