# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let!(:user) { create(:user) }
  before do
    sign_in user
    get :new
  end
  describe 'new method' do
    it 'returns :ok response' do
      is_expected.to respond_with :ok
    end

    it 'renders :new template' do
      is_expected.to render_template :new
    end

    it 'assigns @calculation' do
      expect(assigns(:calculation)).to be_a_new(Calculation)
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
