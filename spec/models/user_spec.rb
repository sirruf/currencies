# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it 'has many calculations' do
      should have_many(:calculations).dependent(:destroy)
    end
  end
end
