module Colour::ColourScopes
  def self.included(base)
    base.class_eval do
      def self.get_uniq_common_colors
        # Insert .map to solve the problem - if one color get many optional colors
        pluck(:common_colors).map{|hash| Hash[*hash.first] }.reduce({}, :merge)
      end
    end
  end
end