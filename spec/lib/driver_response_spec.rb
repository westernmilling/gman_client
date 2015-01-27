require 'spec_helper'
require 'gman_client'
require 'vcr'
require 'httparty'
require 'webmock'
require 'support/vcr'

RSpec.describe GmanClient do
  describe '.drivers' do
    let(:response) do
      VCR.use_cassette('drivers') do
        GmanClient.drivers
      end
    end
    subject(:client_response) { response }
    let(:driver) { client_response.first }

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
      it { is_expected.to have_key(:first_name) }
      it { is_expected.to have_key(:last_name) }
    end
  end
end
