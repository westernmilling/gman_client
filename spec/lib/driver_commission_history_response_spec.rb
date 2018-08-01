# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GmanClient do
  describe '.driver_commission_histories' do
    let(:response) do
      VCR.use_cassette('driver_commission_histories') do
        gman_adapter.driver_commission_histories
      end
    end

    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }

    it 'client response will not be empty' do
      is_expected.not_to be_empty
    end

    it 'responds with a hash list' do
      is_expected.to satisfy { |h|
                       h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first driver' do
      subject { client_response.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:backhauls) }
      it { is_expected.to have_key(:freight_revenue) }
      it { is_expected.to have_key(:customer_name) }
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
      it { is_expected.to have_key(:drvrcomh_key) }
    end
  end
  describe '.driver_commission_histories_by_paid_date' do
    let(:response) do
      VCR.use_cassette('driver_commission_histories_by_paid_date') do
        gman_adapter.driver_commission_histories_by_paid_date(
          Date.new(2014, 1, 1)
        )
      end
    end
    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }
    it 'client response will not be empty' do
      is_expected.not_to be_empty
    end

    it 'responds with a hash list' do
      is_expected.to satisfy { |h|
                       h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first driver' do
      subject { client_response.first }

      it { is_expected.to have_key(:driver_id) }
      it { is_expected.to have_key(:backhauls) }
      it { is_expected.to have_key(:freight_revenue) }
      it { is_expected.to have_key(:customer_name) }
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
      it { is_expected.to have_key(:drvrcomh_key) }
      it { is_expected.to have_value(Date.new(2014, 1, 1).to_s) }
    end
  end
end
