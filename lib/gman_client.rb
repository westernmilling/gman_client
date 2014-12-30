require 'gman_client/version'
require 'plissken'
require 'httparty'

# GmanClient
module GmanClient
  def self.receive_drivers
    request = HTTParty.get('http://localhost:3000/api/v1/drivers.json')
    # request = HTTParty.get('http://example.com//api/v1/drivers.json')
    request.parsed_response.map(&:to_snake_keys)
  end
end
