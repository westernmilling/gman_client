require 'sinatra'

module FakeGmanServices
  class Server < Sinatra::Base
    @access_token = nil
    @orders_hash = []

    class << self
      attr_accessor :access_token, :orders_hash
    end

    get '/api/v1/orders' do
      content_type :json

      puts headers

      status 401
    end
  end
end
