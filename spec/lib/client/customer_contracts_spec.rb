# frozen_string_literal: true

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

  let(:customer_contracts_hash) do
    [
      {
        contract_id: '50000000',
        contract_type: 'Sale',
        customer_id: '00010000',
        location_id: '01'
      },
      {
        contract_id: '50000100',
        contract_type: 'Sale',
        customer_id: '00010000',
        location_id: '01'
      }
    ]
  end

  describe '#customer_contracts' do
    let(:described) { client.customer_contracts(params) }
    let(:stubbed_url) { 'http://test.local' }

    context 'when customer contracts are found' do
      before do
        stub_request(:post, "#{stubbed_url}/oauth/token")
          .to_return(
            body: { access_token: access_token }.to_json, status: 200
          )
        stub_request(
          :get, "#{stubbed_url}/api/v1/customer_contracts.json?#{query_string}"
        )
          .to_return(body: customer_contracts_hash.to_json, status: 200)
      end
      let(:access_token) { SecureRandom.uuid }
      let(:params) do
        {
          customer_id: '00010000'
        }
      end
      let(:query_string) do
        params.map { |k, v| "q[#{k}]=#{v}" }.join('&')
      end

      describe 'response' do
        subject { described }

        it { is_expected.to be_kind_of(Array) }
        its(:size) { is_expected.to eq 2 }

        describe 'first match' do
          subject { described[0] }

          its([:contract_id]) do
            is_expected.to eq customer_contracts_hash[0][:contract_id]
          end
          its([:contract_type]) do
            is_expected.to eq customer_contracts_hash[0][:contract_type]
          end
          its([:customer_id]) do
            is_expected.to eq customer_contracts_hash[0][:customer_id]
          end
          its([:location_id]) do
            is_expected.to eq customer_contracts_hash[0][:location_id]
          end
        end
        describe 'second match' do
          subject { described[1] }

          its([:contract_id]) do
            is_expected.to eq customer_contracts_hash[1][:contract_id]
          end
          its([:contract_type]) do
            is_expected.to eq customer_contracts_hash[1][:contract_type]
          end
          its([:customer_id]) do
            is_expected.to eq customer_contracts_hash[1][:customer_id]
          end
          its([:location_id]) do
            is_expected.to eq customer_contracts_hash[1][:location_id]
          end
        end
      end
    end
  end
end
