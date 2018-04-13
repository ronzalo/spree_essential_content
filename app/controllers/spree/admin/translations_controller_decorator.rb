module Spree
  module Admin
    TranslationsController.class_eval do
      def slugged_models
        ["SpreeProduct", "SpreePage"]
      end
    end
  end
end