require 'spec_helper'

RSpec.describe Gman::Client do
  include_context 'grossman client'

  describe '#order' do
    let(:response) do
      client.order()
    end
    subject { response }

  end
end
