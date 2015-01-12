require 'gman_client/version'
require 'rest_client'
require 'json'
require 'blanket'

# GmanClient
module GmanClient
  class << self
    def drivers
      token = retrieve_token
      @url = ENV['WRAP_URL']
      request = Blanket.wrap(
          'http://localhost:3000',
          :extension => :json,
          :headers => { 'Authorization' => "Bearer #{token}" }
      )
      respond = request.api.v1.drivers.get
      respond.map(&:to_h)
    end

    def driver_commission_histories
      token = retrieve_token
      request = Blanket.wrap(
          'http://localhost:3000',
          :extension => :json,
          :headers => { 'Authorization' => "Bearer #{token}" }
      )
      respond = request.api.v1.driver_commissions_history.get
      respond.map(&:to_h)
    end

    def driver_commission_histories_by_paid_date(paid_date)
      token = retrieve_token
      request = Blanket.wrap('http://localhost:3000',
                             :extension => :json,
                             :headers => {
                               'Authorization' => "Bearer #{token}" })
      respond = request.api.v1.driver_commissions_history_by_paid_date
                .get(:params => { :paid_date => paid_date })
      respond.map(&:to_h)
    end
  end
end

private

def retrieve_token
  client_id =
      ENV['CLIENT_ID']
  #    'f444a467ddbbaed52297d61a3edc5efd93e9292fc542058786aa13fa366865a3'
  client_secret =
      ENV['CLIENT_SECRET']
  # 'd137a94543da86e52214d3ed86b015f9299ad2fc66681637600afad814cd7d2b'
  # response = RestClient.post 'http://localhost:3000/oauth/token',
  response = RestClient.post ENV['TOKEN_URL'],
                             :grant_type => 'client_credentials',
                             :client_id => client_id,
                             :client_secret => client_secret

  JSON.parse(response)['access_token']
end
