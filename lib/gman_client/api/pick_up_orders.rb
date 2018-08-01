# frozen_string_literal: true

module GmanClient
  module Api
    module PickUpOrders
      # Retrieves pick up orders
      #
      # @param [Hash] parameters to filter the pick up orders
      def pick_up_orders(filter_params)
        response = attempt(@retry_attempts) do
          get(:pick_up_orders, q: filter_params)
        end

        response.map(&:to_h)
      end
    end
  end
end
