module Colour::ColourScopes
  def self.included(base)
    base.class_eval do
      def self.get_uniq_common_colors
        pluck(:common_colors).reduce({}, :merge)
      end
    end
  end
end