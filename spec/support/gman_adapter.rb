def gman_adapter
  url = 'http://localhost:3000'
  token_url = 'http://localhost:3000/oauth/token'
  # rubocop:disable Metrics/LineLength
  client_id = 'd137a94543da86e52214d3ed86b015f9299ad2fc66681637600afad814cd7d2b'
  client_secret = 'f444a467ddbbaed52297d61a3edc5efd93e9292fc542058786aa13fa366865a3'
  # rubocop:enable Metrics/LineLength

  Gman::Client.new(:url => url,
                   :token_url => token_url,
                   :client_id => client_id,
                   :client_secret => client_secret
                  )
end
