# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Gman::Client do
  before(:all) { VCR.turn_off! }
  after(:all) { VCR.turn_on! }

  let(:access_token) { SecureRandom.uuid }
  let(:stubbed_url) { 'http://test.local' }

  include_context 'new grossman client' do
    let(:url) { stubbed_url }
    let(:client_id) { SecureRandom.uuid }
    let(:client_secret) { SecureRandom.uuid }
  end

  describe '#pick_up_orders' do
    subject do
      client.pick_up_orders(params)
    end

    before do
      stub_request(:post, "#{stubbed_url}/oauth/token")
        .to_return(
          body: { access_token: access_token }.to_json, status: 200
        )

      stub_request(
        :get, "#{stubbed_url}/api/v1/pick_up_orders.json?#{query_string}"
      )
        .to_return(body: pick_up_orders_hash.to_json, status: 200)
    end

    let(:query_string) do
      params.map { |k, v| "q[#{k}]=#{v}" }.join('&')
    end

    context 'when there are results' do
      let(:params) do
        {
          contract_commodity_id_eq: 1010
        }
      end
      let(:pick_up_orders_hash) do
        [
          {
            contract_id: '10000100',
            contract_location_id: 1,
            commodity_id: 1070,
            item_id: '1234',
            load_number: 1,
            origin: 'HTV',
            origin_state: 'CA',
            origin_weight_certificate: 0,
            origin_tare_weight: 0,
            origin_gross_weight: 0,
            origin_net_weight: 0,
            pickup_type: 'Contract',
            purchase_customer_id: '00000100',
            release_prefix: 'TEST',
            release_load_number: 1,
            release_number: 'TEST      0001',
            ship_date: '2016-12-28',
            status: 'Used'
          },
          {
            contract_id: '10000100',
            contract_location_id: 1,
            commodity_id: 1070,
            item_id: '1234',
            load_number: 2,
            origin: 'HTV',
            origin_state: 'CA',
            origin_weight_certificate: 0,
            origin_tare_weight: 0,
            origin_gross_weight: 0,
            origin_net_weight: 0,
            pickup_type: 'Contract',
            purchase_customer_id: '00000100',
            release_prefix: 'TEST',
            release_load_number: 2,
            release_number: 'TEST      0002',
            ship_date: '2016-12-28',
            status: 'Open'
          }
        ]
      end

      it 'should respond with a collection of hashs' do
        expect(subject).to all be_kind_of(Hash)
      end

      it 'should contain the pick up orders' do
        expect(subject).to eq(pick_up_orders_hash)
      end
    end

    context 'when there are no results' do
      let(:params) { {} }
      let(:pick_up_orders_hash) { [] }

      it { is_expected.to be_empty }
    end
  end
end
