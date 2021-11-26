module Api
  module V1
    class OrdersController < ApplicationController
      before_action :search_order, :check_line_item_ids, only: :update

      def create
        created = Order.create!(order_params)
        render_response(:ok)
      rescue ActiveRecord::RecordInvalid
        render_response(:bad_request, 'RECORD_INVALID')
      end

      def update
        @order.update!(order_params)
        render_response(:ok)
      rescue StandardError
        render_response(:bad_request, 'ORDER_NOT_UPDATED') 
      end

      private

      def order_params
        params.require(:order).permit(:id, line_items_attributes: [:id, :quantity, :amount])
      end

      def search_order
        @order = Order.find(params[:id])
      end

      def check_line_item_ids
        missing_keys = order_params[:line_items_attributes].any? {|line_item| line_item[:id].nil? }
        if missing_keys
          render_response(:bad_request, 'MISSING_KEYS')
        end
      end

      def render_response(status, error_message = nil)
        render json: { success: error_message.nil?, error: error_message }, status: status
      end
    end
  end
end