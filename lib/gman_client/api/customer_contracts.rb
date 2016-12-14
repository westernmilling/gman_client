module GmanClient
  module Api
    module CustomerContracts
      # Retrieves customer contracts
      #
      # @param [Hash] parameters to filter the orders
      def customer_contracts(filter_params)
        response = attempt(@retry_attempts) do
          request
            .api
            .v1
            .customer_contracts
            .get(params: { q: filter_params })
        end

        response.map(&:to_h)
      end
    end
  end
end
