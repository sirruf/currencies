# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:calc) { create(:calculation, user: user) }
  before do
    sign_in user
    get :show, params: { id: calc.id }
  end
  describe 'show ' do
    it 'returns :ok responce and renders :show template' do
      is_expected.to respond_with :ok
      is_expected.to render_template :show
    end

    it 'assigns @calculation' do
      expect(assigns(:calculation)).to eq(calc)
    end

    it 'returns 404 if calculation not found' do
      assert_raises(ActiveRecord::RecordNotFound) do
        get :show, params: { id: 0 }
      end
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      get :show, params: { id: calc.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
