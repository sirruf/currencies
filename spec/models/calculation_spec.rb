# frozen_string_literal: true

require 'rails_helper'

describe Calculation, type: :model do
  let!(:user) { create(:user, email: 'bob@example.com', password: 'qweqweqwe') }
  before(:each) do
    login('bob@mail.ru', 'qweqweqwe')
  end
end
