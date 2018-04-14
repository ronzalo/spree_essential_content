# frozen_string_literal: true

class Spree::PostCategory < ActiveRecord::Base
  validates :name, presence: true
  validates :permalink, presence: true, uniqueness: true

  has_and_belongs_to_many :posts, -> { distinct }, join_table: 'spree_post_categories_posts'

  before_validation :create_permalink

  def to_param
    permalink
  end

  private

  def create_permalink
    return unless permalink == ''
    count = 2
    new_permalink = name.to_s.parameterize
    exists = permalink_exists?(new_permalink)
    while exists
      dupe_permalink = "#{new_permalink}-#{count}"
      exists = permalink_exists?(dupe_permalink)
      count += 1
    end
    self.permalink = dupe_permalink || new_permalink
  end

  def permalink_exists?(new_permalink)
    post_category = Spree::PostCategory.find_by_permalink(new_permalink)
    !post_category.nil? && post_category != self
  end
end
