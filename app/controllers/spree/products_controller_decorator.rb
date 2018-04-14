# frozen_string_literal: true

Spree::ProductsController.class_eval do
  helper 'spree/blogs/posts'
end
