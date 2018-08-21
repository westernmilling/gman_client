# frozen_string_literal: true

module Gman
  class Client
    include GmanClient::Api::CustomerContracts
    include GmanClient::Api::Orders
    include GmanClient::Api::PickUpOrders
    include GmanClient::Api::HealthCheck
    include GmanClient::CommodityMerchandising::Contracts
    include GmanClient::CommodityMerchandising::BulkContracts
    include GmanClient::Utility

    attr_accessor :url, :client_id, :client_secret

    def initialize(options)
      @url = options[:url]
      @token_url = "#{url}/oauth/token"
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @retry_attempts = options[:retries] || 3
    end

    def drivers
      response = attempt(3) { request.api.v1.drivers.get }
      convert_payload(response)
    end

    def driver_commission_histories
      response = attempt(3) do
        request.api.v1.driver_commissions_history.get
      end
      convert_payload(response)
    end

    def driver_commission_histories_by_paid_date(paid_date)
      response = attempt(3) do
        request
          .api
          .v1
          .driver_commissions_history_by_paid_date
          .get(params: { paid_date: paid_date })
      end
      convert_payload(response)
    end

    def inventory_items
      response = attempt(3) { request.api.v1.inventory.items.get }
      convert_payload(response)
    end

    def inventory_items_like_id_description(item_id, in_item_description)
      response = attempt(3) do
        request
          .api
          .v1
          .inventory
          .items_like_id_description
          .get(
            params:
              {
                item_id: item_id,
                in_item_description: in_item_description
              }
          )
      end
      convert_payload(response)
    end

    def inventory_items_by_id(item_id)
      response = attempt(3) do
        request
          .api
          .v1
          .inventory
          .items_by_id
          .get(params: { item_id: item_id })
      end
      convert_payload([response].flatten)
    end
  end
end
