# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:calc) { create(:calculation, user: user) }

  before do
    sign_in user
    get :edit, params: { id: calc.id }
  end

  describe 'edit method' do
    it 'returns :ok response' do
      is_expected.to respond_with :ok
    end

    it 'renders :edit template' do
      is_expected.to render_template :edit
    end

    it 'assigns @calculation' do
      expect(assigns(:calculation)).to eq(calc)
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      get :edit, params: { id: calc.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
