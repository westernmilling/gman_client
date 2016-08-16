module GmanClient
  module Api
    # Orders API
    module Orders
      # Retrieve a single order
      #
      # @param [String] uuid identifies the order
      def order(uuid)
        response = attempt(@retry_attempts) do
          request
            .api
            .v1
            .orders(uuid)
            .get
        end

        response.to_h
      end
    end
  end
end
