# frozen_string_literal: true

#
# Calculations
#
class CalculationsController < ApplicationController
  before_action :set_calculation, only: %i[show edit update destroy]

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Calculations', :calculations_path

  def index
    @calculations = Calculation.all
  end

  def show
    add_breadcrumb @calculation.id, nil
    error = 'Rates are updating. Please, reload this page in minutes.'
    flash[:alert] = error unless @calculation.data_ready?
  end

  def new
    add_breadcrumb 'New', nil
    @calculation = Calculation.new
  end

  def create
    add_breadcrumb 'New', nil
    @calculation = Calculation.new(calculation_params)
    if @calculation.save
      redirect_to calculations_path(@calculation),
                  notice: 'Calculation was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    add_breadcrumb @calculation.id, calculation_path(@calculation)
    add_breadcrumb 'Edit', calculation_path(@calculation)
  end

  def update
    add_breadcrumb @calculation.id, calculation_path(@calculation)
    add_breadcrumb 'Edit', calculation_path(@calculation)
    if @calculation.update(calculation_params)
      redirect_to calculation_path(@calculation),
                  notice: 'Calculation was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @calculation.destroy
    redirect_to calculations_path
  end

  private

  def set_calculation
    @calculation = Calculation.find(params[:id])
  end

  def calculation_params
    params.require(:calculation).permit(:base_currency,
                                        :target_currency,
                                        :amount,
                                        :max_weeks)
  end
end
