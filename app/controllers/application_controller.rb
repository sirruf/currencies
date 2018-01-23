# frozen_string_literal: true

#
# Main Controller
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
