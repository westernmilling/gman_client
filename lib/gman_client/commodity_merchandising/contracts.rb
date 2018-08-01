# frozen_string_literal: true

module GmanClient
  module CommodityMerchandising
    module Contracts
      def contracts(filters)
        response = attempt(@retry_attempts) do
          request
            .api
            .v1
            .commodity_merchandising
            .contracts
            .get(params: { q: clean_filters(filters) })
        end

        response
          .map(&:to_h)
      end

      def clean_filters(filters)
        keep = filters.select do |k, _v|
          [
            :commodity_id_eq,
            :contract_type_eq,
            :customer_id_eq,
            :inv_contract_id_eq,
            :location_id_eq
          ].include?(k)
        end

        Hash[filters.to_a & keep.to_a]
      end
    end
  end
end
