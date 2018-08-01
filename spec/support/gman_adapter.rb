# frozen_string_literal: true

def gman_adapter
  url = ENV['GMAN_SERVICES_URL']
  client_id = ENV['GMAN_SERVICES_CLIENT_ID']
  client_secret = ENV['GMAN_SERVICES_CLIENT_SECRET']

  Gman::Client.new(
    url: url,
    client_id: client_id,
    client_secret: client_secret
  )
end
