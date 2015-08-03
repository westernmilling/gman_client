require 'gman_client/version'
require 'rest_client'
require 'json'
require 'blanket'
require 'hashie'
require 'retries'

# GmanClient
module Gman
  # grossman +client+ object
  class Client
    attr_accessor :url, :token_url, :client_id, :client_secret
    def initialize(options = {})
      @url =  options[:url] || ENV['WRAP_URL']
      @token_url = options[:token_url] || ENV['TOKEN_URL']
      @client_id = options[:client_id] || ENV['CLIENT_ID']
      @client_secret = options[:client_secret] || ENV['CLIENT_SECRET']
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
        request.api.v1.driver_commissions_history_by_paid_date
        .get(:params => { :paid_date => paid_date })
      end
      convert_payload(response)
    end

    def inventory_items
      response = attempt(3) { request.api.v1.inventory.items.get }
      convert_payload(response)
    end

    def inventory_items_like_id_description(item_id, in_item_description)
      response = attempt(3) do
        request.api.v1.inventory.items_like_id_description
        .get(:params => { :item_id => item_id,
                          :in_item_description => in_item_description }
            )
      end
      convert_payload(response)
    end

    def inventory_items_by_id(item_id)
      response = attempt(3) do
        request.api.v1.inventory.items_by_id
        .get(:params => { :item_id => item_id })
      end
      convert_payload(response)
    end

    def request
      token = retrieve_token
      Blanket.wrap(@url.dup,
                   :extension => :json,
                   :headers => {
                     'Authorization' => "Bearer #{token}" }
                  )
    end

    def retrieve_token
      response = RestClient.post @token_url.dup,
                                 :grant_type => 'client_credentials',
                                 :client_id => @client_id.dup,
                                 :client_secret => @client_secret.dup

      JSON.parse(response)['access_token']
    end

    private

    def convert_payload(response)
      response.map do |hash_request|
        Hashie.symbolize_keys!(hash_request.to_h)
      end
    end

    def attempt(retry_count)
      with_retries(:max_tries => retry_count) { yield }
    end
  end
end
