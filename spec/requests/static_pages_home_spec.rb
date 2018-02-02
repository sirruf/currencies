# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static Pages', type: :request do
  it 'renders home page for unauthorized users' do
    get root_path
    expect(response).to be_success
    expect(response.body).to match(/Sign In/)
  end

  it 'renders home page for authorized users' do
    user = create(:user)
    sign_in user

    get root_path
    expect(response).to be_success
    expect(response.body).to match(/Sign Out/)
    expect(response.body).to match(/Calculations/)
  end
end
