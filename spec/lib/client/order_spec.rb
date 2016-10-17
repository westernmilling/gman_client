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
  let(:orders_hash) do
    [
      {
        order_number: 000001,
        order_key: 001,
        quantity_shipped: 5.0,
        ship_date: '2000-01-01',
        warehouse_id: 1,
        uuid: '949085E3-6FC3-4240-BC86-2940D543DB35'
      },
      {
        order_number: 000002,
        order_key: 002,
        quantity_shipped: 5.0,
        ship_date: '2000-01-01',
        warehouse_id: 1,
        uuid: '1AE4C0FD-B1B3-4381-ACF2-62025A6F0D8C'
      }
    ]
  end

  describe '#order' do
    let(:described) { client.order(order_hash[:uuid]) }
    let(:access_token) { SecureRandom.uuid }
    let(:order_hash) { orders_hash.sample }
    let(:stubbed_url) { 'http://test.local' }

    subject do
      described
    end

    context 'when the authorization fails' do
      before do
        stub_request(:post, "#{stubbed_url}/oauth/token")
          .to_return(response)
      end

      let(:response) do
        {
          body: {
            error: 'invalid_client',
            error_description: '...'
          }.to_json,
          status: 401
        }
      end

      it 'should raise RestClient::Unauthorized' do
        expect { subject }.to raise_error(RestClient::Unauthorized)
      end
    end

    context 'when the order is found' do
      before do
        stub_request(:post, "#{stubbed_url}/oauth/token")
          .to_return(
            body: { access_token: access_token }.to_json, status: 200
          )
        stub_request(
          :get, "#{stubbed_url}/api/v1/orders/#{order_hash[:uuid]}.json"
        )
          .to_return(body: order_hash.to_json, status: 200)
      end
      let(:access_token) { SecureRandom.uuid }

      it 'should respond with a Hash' do
        expect(subject).to be_kind_of(Hash)
      end

      describe 'response' do
        its([:order_number]) { is_expected.to eq order_hash[:order_number] }
        its([:order_key]) { is_expected.to eq order_hash[:order_key] }
        its([:quantity_shipped]) do
          is_expected.to eq order_hash[:quantity_shipped]
        end
        its([:ship_date]) { is_expected.to eq order_hash[:ship_date] }
        its([:warehouse_id]) { is_expected.to eq order_hash[:warehouse_id] }
        its([:uuid]) { is_expected.to eq order_hash[:uuid] }
      end
    end
  end
end
