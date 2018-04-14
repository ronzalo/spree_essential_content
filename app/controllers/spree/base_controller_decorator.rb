# frozen_string_literal: true

Spree::BaseController.class_eval do
  before_action :get_pages
  helper_method :current_page

  def current_page
    puts '*' * 50
    puts locale
    puts '*' * 50
    @page ||= Spree::Page.find_by_path(request.path)
  end

  def get_pages
    return if request.path =~ /^\/+admin/
    @pages ||= Spree::Page.visible.order(:position)
  end
end
