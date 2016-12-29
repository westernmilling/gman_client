module GmanClient
  module Utility
    def get(resource, params)
      request
        .api
        .v1
        .send(resource)
        .get(params: params)
    end

    def request
      Blanket.wrap(
        @url,
        extension: :json,
        headers: { 'Authorization' => "Bearer #{token}" }
      )
    end

    def token
      return @token if @token

      response = RestClient.post(@token_url,
                                 grant_type: 'client_credentials',
                                 client_id: @client_id,
                                 client_secret: @client_secret)

      @token = JSON.parse(response)['access_token']
    end

    def convert_payload(response)
      response.map do |hash_request|
        Hashie.symbolize_keys!(hash_request.to_h)
      end
    end

    def attempt(retry_count)
      with_retries(max_tries: retry_count) { yield }
    end
  end
end
