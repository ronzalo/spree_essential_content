require 'spree_core'
require "acts-as-taggable-on"

require 'spree_essential_content/engine'

module Spree
  class PossiblePage
    def self.matches?(request)
      path = request.path.gsub(/#{SpreeI18n::Config.available_locales.join("|")}\//, "").sub(%r{^/}, "")
      return false if path =~ Spree::Page::RESERVED_PATHS
      Spree::Page.active.where(path: Spree::Page.normalize_path(path)).any?
    end
  end

  class PossibleBlog
    def self.matches?(request)
      return false if request.path =~ Spree::Blog::RESERVED_PATHS
      path = request.path
      path = path.sub(%r{^/},"").split(%r{/\s*}).reject {|p| SpreeI18n::Config.available_locales.include? p.to_sym}
      path = path[0] unless path == "/"
      Spree::Blog.where(permalink: Spree::Blog.normalize_permalink(path)).any?
    end
  end
end