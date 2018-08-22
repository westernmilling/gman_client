# frozen_string_literal: true

module GmanClient
  module CommodityMerchandising
    module BulkContracts
      def bulk_contracts
        response = attempt(@retry_attempts) do
          request
            .api
            .v1
            .commodity_merchandising
            .bulk_contracts
            .get
        end

        response.map(&:to_h)
      end
    end
  end
end
