# frozen_string_literal: true

module Spree
  module Admin
    TranslationsController.class_eval do
      def slugged_models
        %w[SpreeBlog SpreeProduct SpreePage SpreePost]
      end
    end
  end
end
