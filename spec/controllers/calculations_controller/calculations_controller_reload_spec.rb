# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  include_context 'shared test rates'
  let!(:user) { create(:user) }
  let!(:calc) { create(:calculation, user: user, rates_data: nil) }
  let(:rates_data) { test_rates }

  before do
    sign_in user
    post :reload, params: { id: calc.id }
  end

  describe 'reload method' do
    it 'returns :redirect response' do
      is_expected.to respond_with :redirect
    end

    it 'redirects to show' do
      is_expected.to redirect_to(calculation_path(calc))
    end

    it 'assigns @calculation' do
      expect(assigns(:calculation)).to eq(calc)
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      post :reload, params: { id: calc.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
