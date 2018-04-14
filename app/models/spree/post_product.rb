# frozen_string_literal: true

class Spree::PostProduct < ActiveRecord::Base
  acts_as_list

  belongs_to :post
  belongs_to :product

  validates :post_id, presence: true
  validates :product_id, presence: true
  validate :product_is_not_already_assigned_to_post, if: -> { !post_id.nil? && !product_id.nil? }

  def product_is_not_already_assigned_to_post
    product_scope = Spree::PostProduct.where(post_id: post.id).where(product_id: product.id)
    product_scope = product_scope.where('id != ?', id) unless id.nil?

    unless product_scope.first.nil?
      errors.add(:product_id, 'is already assigned to the post and cannot be added twice.')
    end
  end
end
