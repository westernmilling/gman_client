require 'spec_helper'
require 'gman_client'
require 'vcr'
require 'httparty'
require 'webmock'
require 'support/vcr'

RSpec.describe GmanClient do
  let(:url) { 'http://localhost:3000' }
  let(:token_url) { 'http://localhost:3000/oauth/token' }
  # rubocop:disable Metrics/LineLength
  let(:client_id) { 'd137a94543da86e52214d3ed86b015f9299ad2fc66681637600afad814cd7d2b' }
  let(:client_secret) { 'f444a467ddbbaed52297d61a3edc5efd93e9292fc542058786aa13fa366865a3' }
  # rubocop:enable Metrics/LineLength

  describe '.driver_commission_histories' do
    let(:response) do
      VCR.use_cassette('driver_commission_histories') do
        gman = GmanClient::GC.new(url, token_url, client_id, client_secret)
        gman.driver_commission_histories
      end
    end

    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }

    it 'client response will not be empty' do
      is_expected.not_to be_empty
    end

    it 'responds with a hash list' do
      is_expected.to satisfy {
                         |h| h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first driver' do
      subject { client_response.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:backhauls) }
      it { is_expected.to have_key(:freight_revenue) }
      it { is_expected.to have_key(:customer_id) }
      it { is_expected.to have_key(:delivery_date) }
      it { is_expected.to have_key(:driver_rate) }
      it { is_expected.to have_key(:freight_bill_number) }
      it { is_expected.to have_key(:fuel_surcharge) }
      it { is_expected.to have_key(:layover) }
      it { is_expected.to have_key(:movement_type) }
      it { is_expected.to have_key(:other_hour_dollars) }
      it { is_expected.to have_key(:order_number_text) }
      it { is_expected.to have_key(:origin_name) }
      it { is_expected.to have_key(:paid_date) }
      it { is_expected.to have_key(:revenue) }
      it { is_expected.to have_key(:split_rate) }
      it { is_expected.to have_key(:total_freight_revenue) }
    end
  end
  describe '.driver_commission_histories_by_paid_date' do
    let(:response) do
      VCR.use_cassette('driver_commission_histories_by_paid_date') do
        gman = GmanClient::GC.new(:url => url,
                                  :token_url => token_url,
                                  :client_id => client_id,
                                  :client_secret => client_secret
        )
        gman.driver_commission_histories_by_paid_date(
            Date.new(2012, 01, 01))
      end
    end
    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }
    it 'client response will not be empty' do
      is_expected.not_to be_empty
    end

    it 'responds with a hash list' do
      is_expected.to satisfy {
                         |h| h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first driver' do
      subject { client_response.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:backhauls) }
      it { is_expected.to have_key(:freight_revenue) }
      it { is_expected.to have_key(:customer_id) }
      it { is_expected.to have_key(:delivery_date) }
      it { is_expected.to have_key(:driver_rate) }
      it { is_expected.to have_key(:freight_bill_number) }
      it { is_expected.to have_key(:fuel_surcharge) }
      it { is_expected.to have_key(:layover) }
      it { is_expected.to have_key(:movement_type) }
      it { is_expected.to have_key(:other_hour_dollars) }
      it { is_expected.to have_key(:order_number_text) }
      it { is_expected.to have_key(:origin_name) }
      it { is_expected.to have_key(:paid_date) }
      it { is_expected.to have_key(:revenue) }
      it { is_expected.to have_key(:split_rate) }
      it { is_expected.to have_key(:total_freight_revenue) }
      it { is_expected.to have_value(Date.new(2012, 01, 01).to_s) }
    end
  end
end
