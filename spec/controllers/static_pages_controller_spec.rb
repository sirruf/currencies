# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  before do
    get :home
  end
  describe 'GET home' do
    it 'returns :ok response' do
      expect(response).to be_success
    end
    it 'renders the home template' do
      expect(response).to render_template(:home)
    end
  end
end
