# frozen_string_literal: true

#
# User model
#
class User < ApplicationRecord
  has_many :calculations, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
