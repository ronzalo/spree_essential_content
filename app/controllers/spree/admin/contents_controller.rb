# frozen_string_literal: true

module Spree
  module Admin
    class Spree::Admin::ContentsController < ResourceController
      before_action :load_resource
      before_action :parent, only: :index

      before_action :load_data, only: %i[new edit create update]

      belongs_to 'spree/page'

      private

      def load_data
        @pages = Spree::Page.order(:position).all
      end

      def parent
        @page ||= Spree::Page.where(path: params[:page_id]).first
      end

      def collection
        params[:q] ||= {}
        params[:q][:s] ||= 'position asc'
        @search = parent.contents.search(params[:q])
        @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_orders_per_page])
      end
    end
  end
end
