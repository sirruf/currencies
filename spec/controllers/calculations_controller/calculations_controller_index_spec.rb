# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, email: 'user2@example.com') }
  before do
    sign_in user
    get :index
  end
  describe 'index method' do
    it 'returns :ok response' do
      is_expected.to respond_with :ok
    end

    it 'renders :index template' do
      is_expected.to render_template :index
    end

    it 'assigns @calculations ' do
      calc = create(:calculation, user: user)
      create(:calculation, user: user2)
      get :index
      expect(assigns(:calculations)).to eq([calc])
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
