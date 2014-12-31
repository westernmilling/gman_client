require 'gman_client/version'
require 'blanket'

# GmanClient
module GmanClient
  def self.receive_drivers
    request = Blanket.wrap("http://localhost:3000", :extension => :json)
    respond = request.api.v1.drivers.get
    respond.map(&:to_h)
  end
end
