# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:calc) { create(:calculation, user: user) }

  before do
    sign_in user
    patch :update, params: { id: calc.id, calculation: { base_currency: 'USD',
                                                         target_currency: 'GBP',
                                                         amount: 15_000,
                                                         max_weeks: 1 } }
  end

  describe 'update method' do
    it 'updates @calculation' do
      calc.reload
      expect(calc.base_currency).to eq('USD')
      expect(calc.target_currency).to eq('GBP')
      expect(calc.amount).to eq(15_000)
      expect(calc.max_weeks).to eq(1)
    end
  end
end
