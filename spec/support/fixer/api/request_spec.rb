# frozen_string_literal: true

require 'rails_helper'

describe Fixer::API::Request do
  it 'returns array of dates' do
    expect(Fixer::API::Request).to respond_to(:get).with(2).argument
  end
end
