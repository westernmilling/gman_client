require 'spec_helper'

RSpec.describe Gman::Client do
  include_context 'grossman client'

  let(:customer_id) { 100_001 }
  let(:response) do
    VCR.use_cassette('contracts') do
      client.contracts(customer_id_eq: 100_001, contract_type_eq: 'S')
    end
  end
  subject { response }

  it 'should have a client response' do
    is_expected.not_to be_empty
  end
  it 'should have responded with an array of hashes' do
    is_expected
      .to satisfy { |h| h.is_a?(Array) && h.all? { |e| e.is_a?(Hash) } }
  end
  it 'should match the customer filter' do
    customer_ids = response.map { |hash| hash[:customer_id] }
    expect(customer_ids).to all eq 100_001
  end
  it 'should match the contract type filter' do
    contract_types = response.map { |hash| hash[:contract_type] }
    expect(contract_types).to all eq 'Sale'
  end

  describe 'first contract' do
    subject { response.first }
    its(:keys) do
      is_expected.to include(
        :contract_id,
        :commodity_id,
        :customer_id,
        :contract_number,
        :contract_date,
        :contract_type,
        :inv_contract_id,
        :quantity,
        :delivered_quantity,
        :price,
        :freight_adjustment,
        :from_date,
        :to_date,
        :commodity,
        :unit_of_measure
      )
    end
    describe 'commodity' do
      subject { response.first[:commodity] }

      its(:keys) do
        is_expected.to include(:commodity_id, :description, :conversion_factor)
      end
    end
    describe 'unit_of_measure' do
      subject { response.first[:unit_of_measure] }

      its(:keys) do
        is_expected.to include(:uom_id, :description)
      end
    end
  end
end
