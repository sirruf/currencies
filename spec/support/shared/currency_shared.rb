# frozen_string_literal: true

require 'rails_helper'

shared_context 'shared test currency' do
  let(:number_of_weeks) { 3 }
  let(:currency) { Fixer::Currency.new('USD') }
  let(:rates) { currency.rates(number_of_weeks) }
  let(:dates) { DatesGenerator.new.dates_for(number_of_weeks) }
end

shared_context 'shared vcr options' do
  let(:vcr_options) { { record: :new_episodes } }
end
