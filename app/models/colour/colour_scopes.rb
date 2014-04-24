module Colour::ColourScopes
  def self.included(base)
    base.class_eval do
      def self.get_uniq_common_colors
        # Insert .map to solve the problem - if one color get many optional colors
        main_colours = pluck(:main)
        Colour::COMMON_COLORS_HASH.select{|k, v| k.in? main_colours }
      end
    end
  end
end