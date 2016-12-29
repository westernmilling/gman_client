module GmanClient
  module Api
    module PickUpOrders
      # Retrieves pick up orders
      #
      # @param [Hash] parameters to filter the pick up orders
      def pick_up_orders(filter_params)
        response = attempt(@retry_attempts) do
          request
            .api
            .v1
            .pick_up_orders
            .get(params: { q: filter_params })
        end

        response.map(&:to_h)
      end
    end
  end
end
