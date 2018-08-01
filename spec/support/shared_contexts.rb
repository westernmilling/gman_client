# frozen_string_literal: true

RSpec.shared_context 'grossman client' do
  let(:client) do
    url = ENV['GMAN_SERVICES_URL']
    client_id = ENV['GMAN_SERVICES_CLIENT_ID']
    client_secret = ENV['GMAN_SERVICES_CLIENT_SECRET']

    Gman::Client.new(
      url: url,
      client_id: client_id,
      client_secret: client_secret
    )
  end
end

RSpec.shared_context 'new grossman client' do
  let(:client) do
    Gman::Client.new(
      url: url,
      client_id: client_id,
      client_secret: client_secret
    )
  end
end
