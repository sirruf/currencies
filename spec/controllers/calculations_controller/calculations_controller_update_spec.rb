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
    it 'redirects to show' do
      is_expected.to respond_with :redirect
      is_expected.to redirect_to(calculation_path(calc))
    end

    it 'assigns @calculation' do
      expect(assigns(:calculation)).to eq(calc)
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      patch :update, params: { id: calc.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
