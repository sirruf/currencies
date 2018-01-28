# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :calculations do
    post 'reload', action: :reload, on: :member
  end
end
