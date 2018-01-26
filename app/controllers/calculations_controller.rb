# frozen_string_literal: true

#
# Calculations
#
class CalculationsController < ApplicationController
  before_action :set_calculation, only: %i[show edit destroy]

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Calculations', :calculations_path

  def index
    @calculations = Calculation.all
  end

  def show
    add_breadcrumb @calculation.id, nil
  end

  def edit; end

  private

  def set_calculation
    @calculation = Calculation.find(params[:id])
  end

  def calculation_params
    @params = Calculation.first
  end
end
