# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Gman::Client do
  describe '.drivers' do
    let(:response) do
      VCR.use_cassette('drivers') do
        gman_adapter.drivers
      end
    end
    subject(:client_response) { response }
    let(:driver) { client_response.first }

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
      its(:keys) do
        is_expected.to eq([:driver_id,
                           :active_fg,
                           :driver_type,
                           :sub_hauler_fg,
                           :first_name,
                           :last_name])
      end
    end
  end
end
