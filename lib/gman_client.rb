require 'gman_client/version'
require 'rest_client'
require 'json'
require 'blanket'

# GmanClient
module GmanClient
  @url = ENV['WRAP_URL']
  @token_url = ENV['TOKEN_URL']
  @client_id = ENV['CLIENT_ID']
  @client_secret = ENV['CLIENT_SECRET']
  class << self
    attr_accessor :url, :token_url, :client_id, :client_secret

    def drivers
      respond = request.api.v1.drivers.get
      respond.map(&:to_h)
    end

    def driver_commission_histories
      respond = request.api.v1.driver_commissions_history.get
      respond.map(&:to_h)
    end

    def driver_commission_histories_by_paid_date(paid_date)
      respond = request.api.v1.driver_commissions_history_by_paid_date
                .get(:params => { :paid_date => paid_date })
      respond.map(&:to_h)
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
  end
end
