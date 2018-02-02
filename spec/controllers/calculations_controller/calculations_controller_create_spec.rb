# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  include_context 'shared calculation params'
  let!(:user) { create(:user) }
  let!(:c_params) { calc_params }
  before do
    sign_in user
    post :create, params: c_params
  end
  describe 'create method' do
    it 'returns :ok response' do
      is_expected.to redirect_to(calculation_path(Calculation.last))
    end

    it 'creates new calculation' do
      expect do
        post :create, params: c_params
      end.to change(Calculation, :count).by(1)
    end

    it 'assigns @calculation' do
      expect(assigns(:calculation)).to eq(Calculation.last)
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
