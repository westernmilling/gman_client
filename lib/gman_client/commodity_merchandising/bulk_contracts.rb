# frozen_string_literal: true

module GmanClient
  module CommodityMerchandising
    module BulkContracts
      def bulk_contracts(customer_ids)
        response = attempt(@retry_attempts) do
          request
            .api
            .v1
            .commodity_merchandising
            .bulk_contracts
            .get(params: { customer_ids: customer_ids.join(',') })
        end

        puts response.inspect
        JSON.parse(response)
      end
    end
  end
end
