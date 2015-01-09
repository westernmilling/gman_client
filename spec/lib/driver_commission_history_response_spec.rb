require 'spec_helper'
require 'gman_client'
require 'vcr'
require 'httparty'
require 'webmock'
require 'support/vcr'

RSpec.describe GmanClient do
  describe '.driver_commission_histories' do
    VCR.use_cassette('driver_commission_histories') do
      response = GmanClient.driver_commission_histories
      subject(:client_response) { response }
      let(:driver_commission) { client_response.first }

      it 'empty is not false' do
        expect(client_response.empty?).to be_falsey
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
  end
  describe '.driver_commission_histories_by_paid_date' do
    VCR.use_cassette('driver_commission_histories_by_paid_date') do
      response = GmanClient.driver_commission_histories_by_paid_date(
          Date.new(2012, 01, 01))
      subject(:client_response) { response }
      let(:driver_commission) { client_response.first }

      it { expect(client_response.empty?).to be_falsey }

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
end
