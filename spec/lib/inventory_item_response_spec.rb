require 'spec_helper'

RSpec.describe GmanClient do
  describe '.inventory_items' do
    let(:response) do
      VCR.use_cassette('inventory_items') do
        gman_adapter.inventory_items
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

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
    end
  end

  describe '.inventory_items_like_id_description' do
    let(:response) do
      VCR.use_cassette('inventory_items_like_id_description') do
        gman_adapter.inventory_items_like_id_description(9370, 'Rachelle')
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
        gman_adapter.inventory_items_by_id('80')
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

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
      it { is_expected.to have_value('80') }
      it { is_expected.to have_value('Corn Gluten Feed') }
    end
  end
end
