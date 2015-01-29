require 'gman_client/version'
require 'rest_client'
require 'json'
require 'blanket'

# GmanClient
module GmanClient
  # GC
  class GC
    attr_accessor :url, :token_url, :client_id, :client_secret
    def initialize(options = {})
      @url =  options[:url] || ENV['WRAP_URL']
      @token_url = options[:token_url] || ENV['TOKEN_URL']
      @client_id = options[:client_id] || ENV['CLIENT_ID']
      @client_secret = options[:client_secret] || ENV['CLIENT_SECRET']
    end
    # class << self

    def drivers
      response = request.api.v1.drivers.get
      convert_payload(response)
    end

    def driver_commission_histories
      response = request.api.v1.driver_commissions_history.get
      convert_payload(response)
    end

    def driver_commission_histories_by_paid_date(paid_date)
      response = request.api.v1.driver_commissions_history_by_paid_date
                 .get(:params => { :paid_date => paid_date })
      convert_payload(response)
    end

    def inventory_items
      response = request.api.v1.inventory.items.get
      convert_payload(response)
    end

    def inventory_items_like_id_description(item_id, in_item_description)
      response = request.api.v1.inventory.items_like_id_description
                 .get(:params => { :item_id => item_id,
                                   :in_item_description => in_item_description }
                 )
      convert_payload(response)
    end

    def inventory_items_by_id(item_id)
      response = request.api.v1.inventory.items_by_id
                 .get(:params => { :item_id => item_id })
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

    def convert_payload(response)
      response.payload.first.nil? ? [response.to_h] : response.map(&:to_h)
    end
    # end
  end
end
