# frozen_string_literal: true

#
# Calculations
#
class CalculationsController < ApplicationController
  def index
    @calculations = Calculation.all
  end

  def show
    @calculations = Calculation.last
  end

  private

  def params
    @params = Calculation.first
  end
end
