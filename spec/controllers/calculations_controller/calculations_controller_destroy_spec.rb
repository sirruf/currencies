# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:calc) { create(:calculation, user: user) }
  before do
    sign_in user
    delete :destroy, params: { id: calc.id }
  end
  describe 'destroy method' do
    it 'returns :ok response' do
      is_expected.to respond_with :redirect
    end

    it 'redirects to calculations_path' do
      is_expected.to redirect_to(calculations_path)
    end

    it 'destroys @calculation' do
      assert_raises(ActiveRecord::RecordNotFound) do
        delete :destroy, params: { id: calc.id }
      end
    end

    it 'redirects to login page if user is not authenticated' do
      sign_out user
      delete :destroy, params: { id: calc.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
