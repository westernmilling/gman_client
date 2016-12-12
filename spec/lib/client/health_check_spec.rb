require 'spec_helper'
require 'webmock'

RSpec.describe Gman::Client do
  include WebMock::API

  let(:client) do
    Gman::Client.new(
      url: stubbed_url,
      client_id: 'client_id',
      client_secret: 'client_secret'
    )
  end

  describe '#health_check' do
    let(:described) { client.health_check }
    let(:access_token) { SecureRandom.uuid }
    let(:stubbed_url) { 'http://test.local' }

    before do
      stub_request(:post, "#{stubbed_url}/oauth/token")
        .to_return(
          body: { access_token: access_token }.to_json, status: 200
        )
      stub_request(
        :get, "#{stubbed_url}/api/v1/health_check.json"
      )
        .to_return(body: health_check_hash.to_json, status: 200)
    end
    let(:access_token) { SecureRandom.uuid }

    subject do
      described
    end

    context 'when the health check is successful' do
      let(:health_check_hash) { { health_check: 'Passed' } }

      it 'should be true' do
        expect(subject).to eq(true)
      end
    end

    context 'when the health check fails' do
      let(:health_check_hash) { { health_check: 'Failed' } }

      it 'should be false' do
        expect(subject).to eq(false)
      end
    end
  end
end
