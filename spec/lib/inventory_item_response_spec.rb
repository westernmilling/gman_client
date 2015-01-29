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

  describe '.inventory_items' do
    let(:response) do
      VCR.use_cassette('inventory_items') do
        gman = Gman::Client.new(:url => url,
                                :token_url => token_url,
                                :client_id => client_id,
                                :client_secret => client_secret
        )
        gman.inventory_items
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

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
    end
  end

  describe '.inventory_items_like_id_description' do
    let(:response) do
      VCR.use_cassette('inventory_items_like_id_description') do
        gman = Gman::Client.new(:url => url,
                                :token_url => token_url,
                                :client_id => client_id,
                                :client_secret => client_secret
        )
        gman.inventory_items_like_id_description(9370, 'Rachelle')
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
        gman = Gman::Client.new(:url => url,
                                :token_url => token_url,
                                :client_id => client_id,
                                :client_secret => client_secret
        )
        gman.inventory_items_by_id(9370)
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

    describe 'first item' do
      subject { client_response.first }

      it { is_expected.to have_key(:item_id) }
      it { is_expected.to have_key(:in_item_description) }
      it { is_expected.to have_value(9370) }
      it { is_expected.to have_value('Rachelle') }
    end
  end
end
