require 'spec_helper'
require 'gman_client'
require 'vcr'
require 'httparty'
require 'webmock'
require 'support/vcr'

RSpec.describe GmanClient do
  describe '.inventory_items' do
    let(:response) do
      VCR.use_cassette('inventory_items') do
        GmanClient.inventory_items
      end
    end

    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }

    it 'client response will not be empty' do
      expect(client_response.empty?).to be_falsey
    end

    it 'responds with a hash list' do
      is_expected.to satisfy {
                         |h| h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
    end
  end

  describe '.inventory_items_like_id_description' do
    let(:response) do
      VCR.use_cassette('inventory_items_like_id_description') do
        GmanClient.inventory_items_like_id_description(9370, 'Rachelle')
      end
    end
    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }
    it 'client response will not be empty' do
      expect(client_response.empty?).to be_falsey
    end

    it 'responds with a hash list' do
      is_expected.to satisfy {
                         |h| h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
      it { is_expected.to have_value(9370) }
      it { is_expected.to have_value('Rachelle') }
    end
  end

  describe '.inventory_items_by_id' do
    let(:response) do
      VCR.use_cassette('inventory_items_by_id') do
        GmanClient.inventory_items_by_id(9370)
      end
    end
    subject(:client_response) { response }
    let(:driver_commission) { client_response.first }
    it 'client response will not be empty' do
      expect(client_response.empty?).to be_falsey
    end

    it 'responds with a hash list' do
      is_expected.to satisfy {
                         |h| h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) }
                     }
    end

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
      it { is_expected.to have_value(9370) }
      it { is_expected.to have_value('Rachelle') }
    end
  end
end
