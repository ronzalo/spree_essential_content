# frozen_string_literal: true

module Spree
  module Admin
    TranslationsController.class_eval do
      def slugged_models
        %w[SpreeProduct SpreePage]
      end
    end
  end
end
